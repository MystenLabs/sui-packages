module 0xbb40504003ab3645f526dd2051808f2ed4fdf3265e6dc10627732876b9a13710::fishing_rod {
    struct FISHING_ROD has drop {
        dummy_field: bool,
    }

    struct FishingRod<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        rarity: 0x1::string::String,
        image_url: 0x1::string::String,
        level: u8,
        exp: u16,
        sea: u16,
        river: u16,
        power: u16,
        speed: u16,
    }

    struct DeleteReceipt has store, key {
        id: 0x2::object::UID,
        rod_id: 0x2::object::ID,
    }

    struct FishingRodMinted has copy, drop {
        rod_id: 0x2::object::ID,
        recipient: address,
        name: 0x1::string::String,
    }

    public fun delete_rod<T0>(arg0: FishingRod<T0>, arg1: &mut 0x2::tx_context::TxContext) : DeleteReceipt {
        let FishingRod {
            id        : v0,
            name      : _,
            rarity    : _,
            image_url : _,
            level     : _,
            exp       : _,
            sea       : _,
            river     : _,
            power     : _,
            speed     : _,
        } = arg0;
        let v10 = v0;
        0x2::object::delete(v10);
        DeleteReceipt{
            id     : 0x2::object::new(arg1),
            rod_id : 0x2::object::uid_to_inner(&v10),
        }
    }

    public fun exp<T0>(arg0: &FishingRod<T0>) : u16 {
        arg0.exp
    }

    public fun image_url<T0>(arg0: &FishingRod<T0>) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: FISHING_ROD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<FISHING_ROD>(arg0, arg1);
    }

    public fun level<T0>(arg0: &FishingRod<T0>) : u8 {
        arg0.level
    }

    public fun mint_rod<T0>(arg0: &0xbb40504003ab3645f526dd2051808f2ed4fdf3265e6dc10627732876b9a13710::fishing_1::AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u16, arg6: u16, arg7: u16, arg8: u16, arg9: u16, arg10: &mut 0x2::tx_context::TxContext) : FishingRod<T0> {
        let v0 = 0x2::object::new(arg10);
        let v1 = FishingRodMinted{
            rod_id    : 0x2::object::uid_to_inner(&v0),
            recipient : 0x2::tx_context::sender(arg10),
            name      : 0x1::string::utf8(arg1),
        };
        0x2::event::emit<FishingRodMinted>(v1);
        FishingRod<T0>{
            id        : v0,
            name      : 0x1::string::utf8(arg1),
            rarity    : 0x1::string::utf8(arg2),
            image_url : 0x1::string::utf8(arg3),
            level     : arg4,
            exp       : arg5,
            sea       : arg6,
            river     : arg7,
            power     : arg8,
            speed     : arg9,
        }
    }

    public fun name<T0>(arg0: &FishingRod<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun power<T0>(arg0: &FishingRod<T0>) : u16 {
        arg0.power
    }

    public fun rarity<T0>(arg0: &FishingRod<T0>) : 0x1::string::String {
        arg0.rarity
    }

    public fun river<T0>(arg0: &FishingRod<T0>) : u16 {
        arg0.river
    }

    public fun sea<T0>(arg0: &FishingRod<T0>) : u16 {
        arg0.sea
    }

    public entry fun setup_display<T0: key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<FISHING_ROD>(arg0), 1);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A rod"));
        let v4 = 0x2::display::new_with_fields<T0>(arg0, v0, v2, arg1);
        0x2::display::update_version<T0>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<T0>>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun speed<T0>(arg0: &FishingRod<T0>) : u16 {
        arg0.speed
    }

    public fun uid<T0>(arg0: &FishingRod<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut<T0>(arg0: &mut FishingRod<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

