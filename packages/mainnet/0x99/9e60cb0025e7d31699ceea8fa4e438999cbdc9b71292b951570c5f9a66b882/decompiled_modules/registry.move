module 0x999e60cb0025e7d31699ceea8fa4e438999cbdc9b71292b951570c5f9a66b882::registry {
    struct RegisterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has store, key {
        id: 0x2::object::UID,
        total_supply: u64,
        max_supply: u64,
        airdropped: u64,
        minted: 0x2::table::Table<u64, 0x2::object::ID>,
        register: 0x2::vec_set::VecSet<SuiballEntry>,
    }

    struct SuiballEntry has copy, drop, store {
        supply: u64,
        max_supply: u64,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        video_url: 0x1::string::String,
        creator: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public(friend) fun add_minted(arg0: &mut Registry, arg1: u64, arg2: 0x2::object::ID) {
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.minted, arg1, arg2);
    }

    public entry fun add_to_register(arg0: &RegisterAdminCap, arg1: &mut Registry, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>) {
        let v0 = SuiballEntry{
            supply      : 0,
            max_supply  : arg2,
            description : arg3,
            image_url   : arg4,
            video_url   : arg5,
            creator     : arg6,
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg7, arg8),
        };
        0x2::vec_set::insert<SuiballEntry>(&mut arg1.register, v0);
        arg1.max_supply = arg1.max_supply + arg2;
    }

    public(friend) fun airdrop(arg0: &mut Registry) : u64 {
        arg0.airdropped = arg0.airdropped + 1;
        arg0.airdropped
    }

    public fun attributes(arg0: SuiballEntry) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun collection_max_supply(arg0: &Registry) : u64 {
        arg0.max_supply
    }

    public fun creator(arg0: SuiballEntry) : 0x1::string::String {
        arg0.creator
    }

    public fun description(arg0: SuiballEntry) : 0x1::string::String {
        arg0.description
    }

    public(friend) fun get_minted(arg0: &Registry, arg1: u64) : 0x2::object::ID {
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.minted, arg1)
    }

    public fun image_url(arg0: SuiballEntry) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = Registry{
            id           : 0x2::object::new(arg0),
            total_supply : 0,
            max_supply   : 10000,
            airdropped   : 0,
            minted       : 0x2::table::new<u64, 0x2::object::ID>(arg0),
            register     : 0x2::vec_set::empty<SuiballEntry>(),
        };
        0x2::transfer::share_object<Registry>(v2);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
        let v3 = RegisterAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RegisterAdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun max_supply(arg0: SuiballEntry) : u64 {
        arg0.max_supply
    }

    public(friend) fun mint_data(arg0: &mut Registry) : SuiballEntry {
        let v0 = 0x2::vec_set::into_keys<SuiballEntry>(arg0.register);
        let v1 = 0;
        let v2 = 0;
        loop {
            if (v2 == 0x1::vector::length<SuiballEntry>(&v0)) {
                break
            };
            let v3 = *0x1::vector::borrow<SuiballEntry>(&v0, v2);
            v1 = v1 + v3.max_supply;
            if (v1 > arg0.total_supply) {
                0x1::vector::borrow_mut<SuiballEntry>(&mut v0, v2).supply = v3.supply + 1;
                arg0.total_supply = arg0.total_supply + 1;
                arg0.register = 0x2::vec_set::from_keys<SuiballEntry>(v0);
                return v3
            };
            v2 = v2 + 1;
        };
        abort 13906834741279129602
    }

    public fun supply(arg0: SuiballEntry) : u64 {
        arg0.supply
    }

    public fun total_supply(arg0: &Registry) : u64 {
        arg0.total_supply
    }

    public fun video_url(arg0: SuiballEntry) : 0x1::string::String {
        arg0.video_url
    }

    // decompiled from Move bytecode v6
}

