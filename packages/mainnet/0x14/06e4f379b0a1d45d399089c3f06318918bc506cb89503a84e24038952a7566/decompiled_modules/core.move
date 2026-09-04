module 0x80febc8885804d47c9dfdb08a78d21811fb54d1972418211d709da4937a0d8b2::core {
    struct PrimeCore has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        serial: u64,
        struck_in: 0x1::string::String,
    }

    struct CoreAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CoreConfig has key {
        id: 0x2::object::UID,
        authority: address,
        minted: u64,
        media_base: 0x1::string::String,
    }

    struct CoreMinted has copy, drop {
        core_id: 0x2::object::ID,
        recipient: address,
        serial: u64,
        struck_in: 0x1::string::String,
    }

    struct BurnedForWeapon has copy, drop {
        core_id: 0x2::object::ID,
        owner: address,
        serial: u64,
    }

    struct BurnedForUpgrade has copy, drop {
        core_id: 0x2::object::ID,
        owner: address,
        serial: u64,
        bot_id: 0x2::object::ID,
    }

    struct BurnedForLance has copy, drop {
        core_id: 0x2::object::ID,
        owner: address,
        serial: u64,
    }

    struct LanceReceipt {
        core_id: 0x2::object::ID,
        serial: u64,
        struck_in: 0x1::string::String,
        owner: address,
    }

    struct CORE has drop {
        dummy_field: bool,
    }

    public fun burn_for_lance(arg0: PrimeCore, arg1: &0x2::tx_context::TxContext) : LanceReceipt {
        let PrimeCore {
            id          : v0,
            name        : _,
            description : _,
            media_url   : _,
            serial      : v4,
            struck_in   : v5,
        } = arg0;
        let v6 = v0;
        let v7 = 0x2::object::uid_to_inner(&v6);
        let v8 = 0x2::tx_context::sender(arg1);
        let v9 = BurnedForLance{
            core_id : v7,
            owner   : v8,
            serial  : v4,
        };
        0x2::event::emit<BurnedForLance>(v9);
        0x2::object::delete(v6);
        LanceReceipt{
            core_id   : v7,
            serial    : v4,
            struck_in : v5,
            owner     : v8,
        }
    }

    entry fun burn_for_upgrade(arg0: PrimeCore, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        let PrimeCore {
            id          : v0,
            name        : _,
            description : _,
            media_url   : _,
            serial      : v4,
            struck_in   : _,
        } = arg0;
        let v6 = v0;
        let v7 = BurnedForUpgrade{
            core_id : 0x2::object::uid_to_inner(&v6),
            owner   : 0x2::tx_context::sender(arg2),
            serial  : v4,
            bot_id  : arg1,
        };
        0x2::event::emit<BurnedForUpgrade>(v7);
        0x2::object::delete(v6);
    }

    entry fun burn_for_weapon(arg0: PrimeCore, arg1: &0x2::tx_context::TxContext) {
        let PrimeCore {
            id          : v0,
            name        : _,
            description : _,
            media_url   : _,
            serial      : v4,
            struck_in   : _,
        } = arg0;
        let v6 = v0;
        let v7 = BurnedForWeapon{
            core_id : 0x2::object::uid_to_inner(&v6),
            owner   : 0x2::tx_context::sender(arg1),
            serial  : v4,
        };
        0x2::event::emit<BurnedForWeapon>(v7);
        0x2::object::delete(v6);
    }

    public fun consume_receipt(arg0: LanceReceipt) : (u64, 0x1::string::String, address) {
        let LanceReceipt {
            core_id   : _,
            serial    : v1,
            struck_in : v2,
            owner     : v3,
        } = arg0;
        (v1, v2, v3)
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CORE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection_name"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{media_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{media_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://boombotsai.wal.app/#wastes"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://boombotsai.wal.app"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Boom Bots AI"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Boom Bots Prime Cores"));
        let v5 = 0x2::display::new_with_fields<PrimeCore>(&v0, v1, v3, arg1);
        0x2::display::update_version<PrimeCore>(&mut v5);
        let (v6, v7) = 0x2::transfer_policy::new<PrimeCore>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<PrimeCore>>(v6);
        let v8 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v8);
        0x2::transfer::public_transfer<0x2::display::Display<PrimeCore>>(v5, v8);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<PrimeCore>>(v7, v8);
        let v9 = CoreAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<CoreAdminCap>(v9, v8);
        let v10 = CoreConfig{
            id         : 0x2::object::new(arg1),
            authority  : v8,
            minted     : 0,
            media_base : 0x1::string::utf8(b""),
        };
        0x2::transfer::share_object<CoreConfig>(v10);
    }

    entry fun mint(arg0: &mut CoreConfig, arg1: address, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.authority, 1);
        arg0.minted = arg0.minted + 1;
        let v0 = arg0.minted;
        let v1 = 0x1::string::utf8(b"Prime Core #");
        0x1::string::append(&mut v1, 0x1::u64::to_string(v0));
        let v2 = arg0.media_base;
        0x1::string::append(&mut v2, 0x1::string::utf8(b"prime-core.png"));
        let v3 = PrimeCore{
            id          : 0x2::object::new(arg3),
            name        : v1,
            description : 0x1::string::utf8(b"An intact reactor core from before the fall. Struck by a mining rig, hauled home under fire, and worth exactly one impossible thing."),
            media_url   : v2,
            serial      : v0,
            struck_in   : arg2,
        };
        let v4 = CoreMinted{
            core_id   : 0x2::object::id<PrimeCore>(&v3),
            recipient : arg1,
            serial    : v0,
            struck_in : v3.struck_in,
        };
        0x2::event::emit<CoreMinted>(v4);
        0x2::transfer::public_transfer<PrimeCore>(v3, arg1);
    }

    public fun minted(arg0: &CoreConfig) : u64 {
        arg0.minted
    }

    public fun serial(arg0: &PrimeCore) : u64 {
        arg0.serial
    }

    public fun set_authority(arg0: &CoreAdminCap, arg1: &mut CoreConfig, arg2: address) {
        arg1.authority = arg2;
    }

    public fun set_media_base(arg0: &CoreAdminCap, arg1: &mut CoreConfig, arg2: 0x1::string::String) {
        arg1.media_base = arg2;
    }

    public fun struck_in(arg0: &PrimeCore) : 0x1::string::String {
        arg0.struck_in
    }

    // decompiled from Move bytecode v7
}

