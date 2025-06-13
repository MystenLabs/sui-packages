module 0xf90da5f4a85a94b0677351ba875729c01af7a8cb54f4a46a7cfc350b9985bda3::golden_apple {
    struct GOLDEN_APPLE has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct GoldenApple has store, key {
        id: 0x2::object::UID,
        number: u64,
    }

    struct Supply has key {
        id: 0x2::object::UID,
        total_supply: u64,
    }

    struct GoldenAppleMinted has copy, drop {
        nft_id: 0x2::object::ID,
    }

    public fun checkVersion(arg0: &Version, arg1: u64) {
        assert!(arg1 == arg0.version, 13906834578070437891);
    }

    public fun get_total_supply(arg0: &Supply) : u64 {
        arg0.total_supply
    }

    fun init(arg0: GOLDEN_APPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GOLDEN_APPLE>(arg0, arg1);
        let v1 = 0x2::display::new<GoldenApple>(&v0, arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = Version{
            id      : 0x2::object::new(arg1),
            version : 1,
        };
        let v4 = Supply{
            id           : 0x2::object::new(arg1),
            total_supply : 0,
        };
        0x2::display::add<GoldenApple>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Sektor13: The Golden Apple"));
        0x2::display::add<GoldenApple>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"54686520616765206f6620746865206170706c652066616c6c696e672066726f6d2074686520736b7920697320626568696e642075732e204e6f772c207765207269736520696e746f2074686520736b69657320696e20736561726368206f662069742e0a54686520657261206f6620457269732063617374696e6720697420646f776e206973206f766572e2809420666f72206e6f772c20746865206170706c65206e65656473206f6e6c7920746f2065786973742e0a546f207468652062656172657273206f6620746869732066727569743a204d617920796f75206775617264206974207769746820796f75722073616e6974792c206e6f7420796f75722068656172742e0a5468697320697320776865726520746865206d7974687320617265206d616465207265616c2e"));
        0x2::display::add<GoldenApple>(&mut v1, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<GoldenApple>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://walrus.tusky.io/e48ZWPbBV9DK933KdYIlGFiCHFMnsV4Qot28Ktafj50"));
        0x2::display::update_version<GoldenApple>(&mut v1);
        let (v5, v6) = 0x2::transfer_policy::new<GoldenApple>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<GoldenApple>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<GoldenApple>>(v5);
        0x2::transfer::public_transfer<0x2::display::Display<GoldenApple>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Version>(v3);
        0x2::transfer::share_object<Supply>(v4);
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut Version, arg2: u64) {
        assert!(arg2 > arg1.version, 13906834595250307075);
        arg1.version = arg2;
    }

    public fun mint_golden_apple(arg0: &AdminCap, arg1: &Version, arg2: &mut Supply, arg3: &mut 0x2::tx_context::TxContext) : GoldenApple {
        checkVersion(arg1, 1);
        let v0 = get_total_supply(arg2);
        assert!(v0 < 2000, 13906834651084750849);
        let v1 = GoldenApple{
            id     : 0x2::object::new(arg3),
            number : v0 + 1,
        };
        let v2 = GoldenAppleMinted{nft_id: 0x2::object::id<GoldenApple>(&v1)};
        0x2::event::emit<GoldenAppleMinted>(v2);
        arg2.total_supply = arg2.total_supply + 1;
        v1
    }

    // decompiled from Move bytecode v6
}

