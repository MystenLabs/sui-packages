module 0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::song_bits {
    struct SONG_BITS has drop {
        dummy_field: bool,
    }

    struct Random_Bits has drop {
        dummy_field: bool,
    }

    struct PlatformCap has store, key {
        id: 0x2::object::UID,
    }

    struct SongCap has store, key {
        id: 0x2::object::UID,
    }

    struct SongMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        artist_name: 0x1::string::String,
        other_artist_names: vector<0x1::string::String>,
        name: 0x1::string::String,
        primary_genre: 0x1::string::String,
        secondary_genre: 0x1::string::String,
        length: 0x1::string::String,
        length_ms: u32,
        isrc: 0x1::string::String,
        bit_price: u64,
        supply: 0x2::balance::Supply<T0>,
        total_supply: u64,
        symbol: 0x1::ascii::String,
        icon_url: 0x1::option::Option<0x1::string::String>,
        has_unique_image: bool,
        burnable: bool,
    }

    struct SongBit<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        image_url: 0x1::option::Option<0x1::string::String>,
        metadata_id: 0x2::object::ID,
    }

    struct SongCreated has copy, drop {
        song_metadata: 0x2::object::ID,
        name: 0x1::ascii::String,
    }

    struct BitsCreated<phantom T0> has copy, drop {
        balance: u64,
        image_url: 0x1::option::Option<0x1::string::String>,
        metadata_id: 0x2::object::ID,
    }

    struct BitsBurned<phantom T0> has copy, drop {
        burned_bits: 0x2::object::ID,
        burned_amount: u64,
    }

    struct BitsSplitted<phantom T0> has copy, drop {
        splitted_bits: 0x2::object::ID,
        splitted_amount: u64,
    }

    struct BitsJoined<phantom T0> has copy, drop {
        joined_bits: 0x2::object::ID,
        joined_amount: u64,
    }

    public fun join<T0>(arg0: &mut SongBit<T0>, arg1: SongBit<T0>, arg2: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::Version) : 0x2::object::ID {
        assert!(arg0.metadata_id == arg1.metadata_id, 7);
        0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::checkVersion(arg2, 1);
        let v0 = value<T0>(&arg1);
        assert!(value<T0>(arg0) > 0 && v0 > 0, 4);
        let SongBit {
            id          : v1,
            balance     : v2,
            image_url   : _,
            metadata_id : _,
        } = arg1;
        0x2::balance::join<T0>(&mut arg0.balance, v2);
        0x2::object::delete(v1);
        let v5 = BitsJoined<Random_Bits>{
            joined_bits   : 0x2::object::id<SongBit<T0>>(arg0),
            joined_amount : v0,
        };
        0x2::event::emit<BitsJoined<Random_Bits>>(v5);
        0x2::object::id<SongBit<T0>>(&arg1)
    }

    public fun split<T0>(arg0: &mut SongBit<T0>, arg1: u64, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::Version, arg4: &mut 0x2::tx_context::TxContext) : SongBit<T0> {
        0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::checkVersion(arg3, 1);
        let v0 = value<T0>(arg0);
        assert!(v0 > 1 && arg1 < v0, 4);
        assert!(arg1 > 0, 5);
        let v1 = BitsSplitted<Random_Bits>{
            splitted_bits   : 0x2::object::id<SongBit<T0>>(arg0),
            splitted_amount : arg1,
        };
        0x2::event::emit<BitsSplitted<Random_Bits>>(v1);
        SongBit<T0>{
            id          : 0x2::object::new(arg4),
            balance     : 0x2::balance::split<T0>(&mut arg0.balance, arg1),
            image_url   : arg2,
            metadata_id : arg0.metadata_id,
        }
    }

    public fun value<T0>(arg0: &SongBit<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun burn<T0>(arg0: &mut SongMetadata<T0>, arg1: SongBit<T0>, arg2: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::Version) {
        assert!(arg0.burnable, 3);
        0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::checkVersion(arg2, 1);
        let SongBit {
            id          : v0,
            balance     : v1,
            image_url   : _,
            metadata_id : _,
        } = arg1;
        0x2::balance::decrease_supply<T0>(&mut arg0.supply, v1);
        let v4 = BitsBurned<Random_Bits>{
            burned_bits   : 0x2::object::id<SongBit<T0>>(&arg1),
            burned_amount : 0x2::balance::supply_value<T0>(&arg0.supply) - 0x2::balance::supply_value<T0>(&arg0.supply),
        };
        0x2::event::emit<BitsBurned<Random_Bits>>(v4);
        0x2::object::delete(v0);
    }

    public fun create_and_install_kiosk_extension<T0: drop>(arg0: &SongCap, arg1: T0, arg2: address, arg3: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::checkVersion(arg3, 1);
        let (v0, v1) = 0x2::kiosk::new(arg4);
        let v2 = v1;
        let v3 = v0;
        0x2::kiosk_extension::add<T0>(arg1, &mut v3, &v2, 11, arg4);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, arg2);
    }

    fun init(arg0: SONG_BITS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SONG_BITS>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"balance"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"metadata_id"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{balance}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{metadata_id}"));
        let v5 = 0x2::display::new_with_fields<SongBit<Random_Bits>>(&v0, v1, v3, arg1);
        0x2::display::update_version<SongBit<Random_Bits>>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SongBit<Random_Bits>>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = PlatformCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<PlatformCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = SongCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SongCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun lock_item_in_kiosk<T0: drop>(arg0: T0, arg1: &SongCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: SongBit<Random_Bits>, arg4: &mut 0x2::transfer_policy::TransferPolicy<SongBit<Random_Bits>>, arg5: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::Version) {
        0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::checkVersion(arg5, 1);
        0x2::kiosk_extension::lock<T0, SongBit<Random_Bits>>(arg0, arg2, arg3, arg4);
    }

    public fun new_bits<T0>(arg0: &SongCap, arg1: &mut SongMetadata<T0>, arg2: u64, arg3: 0x1::option::Option<0x1::string::String>, arg4: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::Version, arg5: &mut 0x2::tx_context::TxContext) : SongBit<T0> {
        assert!(arg2 > 0, 5);
        0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::checkVersion(arg4, 1);
        assert!(supply<T0>(arg1) + arg2 <= arg1.total_supply, 1);
        let v0 = 0x2::balance::increase_supply<T0>(&mut arg1.supply, arg2);
        let v1 = BitsCreated<Random_Bits>{
            balance     : 0x2::balance::value<T0>(&v0),
            image_url   : arg3,
            metadata_id : 0x2::object::id<SongMetadata<T0>>(arg1),
        };
        0x2::event::emit<BitsCreated<Random_Bits>>(v1);
        SongBit<T0>{
            id          : 0x2::object::new(arg5),
            balance     : v0,
            image_url   : arg3,
            metadata_id : 0x2::object::id<SongMetadata<T0>>(arg1),
        }
    }

    public fun new_instance(arg0: &PlatformCap) : Random_Bits {
        Random_Bits{dummy_field: false}
    }

    public fun new_song<T0: drop>(arg0: &PlatformCap, arg1: T0, arg2: bool, arg3: u64, arg4: 0x1::ascii::String, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: u32, arg13: 0x1::string::String, arg14: u64, arg15: bool, arg16: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::Version, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 2);
        0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::checkVersion(arg16, 1);
        let v0 = SongMetadata<T0>{
            id                 : 0x2::object::new(arg17),
            artist_name        : arg6,
            other_artist_names : arg7,
            name               : arg8,
            primary_genre      : arg9,
            secondary_genre    : arg10,
            length             : arg11,
            length_ms          : arg12,
            isrc               : arg13,
            bit_price          : arg14,
            supply             : 0x2::balance::create_supply<T0>(arg1),
            total_supply       : arg3,
            symbol             : arg4,
            icon_url           : arg5,
            has_unique_image   : arg15,
            burnable           : arg2,
        };
        let v1 = SongCreated{
            song_metadata : 0x2::object::id<SongMetadata<T0>>(&v0),
            name          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<SongCreated>(v1);
        0x2::transfer::public_share_object<SongMetadata<T0>>(v0);
    }

    public fun secondary_bits<T0>(arg0: &SongCap, arg1: &SongMetadata<T0>, arg2: 0x1::option::Option<0x1::string::String>, arg3: &0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::Version, arg4: &mut 0x2::tx_context::TxContext) : SongBit<T0> {
        assert!(arg1.has_unique_image, 6);
        0x535d48e3495bd15894528449e41d81c89903e3b1473bc88af8e3cc8be117823e::version::checkVersion(arg3, 1);
        let v0 = BitsCreated<Random_Bits>{
            balance     : 0,
            image_url   : arg2,
            metadata_id : 0x2::object::id<SongMetadata<T0>>(arg1),
        };
        0x2::event::emit<BitsCreated<Random_Bits>>(v0);
        SongBit<T0>{
            id          : 0x2::object::new(arg4),
            balance     : 0x2::balance::zero<T0>(),
            image_url   : arg2,
            metadata_id : 0x2::object::id<SongMetadata<T0>>(arg1),
        }
    }

    public fun supply<T0>(arg0: &SongMetadata<T0>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.supply)
    }

    public fun total_supply<T0>(arg0: &SongMetadata<T0>) : u64 {
        arg0.total_supply
    }

    // decompiled from Move bytecode v6
}

