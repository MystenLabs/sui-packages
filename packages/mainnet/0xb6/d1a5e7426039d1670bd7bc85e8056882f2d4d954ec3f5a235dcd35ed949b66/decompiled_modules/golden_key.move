module 0x4c165ea692d6346af99d0c6dda19d0f92cdb9f8747674df1ad9d7c370d74dbc5::golden_key {
    struct GOLDEN_KEY has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MinterCap has key {
        id: 0x2::object::UID,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct GoldenKey has store, key {
        id: 0x2::object::UID,
        number: u64,
    }

    struct GkSupply has key {
        id: 0x2::object::UID,
        total_supply: u64,
        gk_burn_count: u64,
    }

    struct BlacklistedMinters has key {
        id: 0x2::object::UID,
        minters: vector<address>,
    }

    struct MintGoldenKeyEvent has copy, drop {
        recipient: address,
        nft_id: 0x2::object::ID,
    }

    struct GoldenKeyBurnEvent has copy, drop {
        nft_id: 0x2::object::ID,
    }

    public fun blacklist_minter(arg0: &AdminCap, arg1: &Version, arg2: &mut BlacklistedMinters, arg3: address) {
        checkVersion(arg1, 2);
        assert!(!0x1::vector::contains<address>(&arg2.minters, &arg3), 9223372668215230469);
        0x1::vector::push_back<address>(&mut arg2.minters, arg3);
    }

    public fun burn_golden_key(arg0: GoldenKey, arg1: &Version, arg2: &mut GkSupply) {
        checkVersion(arg1, 2);
        arg2.gk_burn_count = arg2.gk_burn_count + 1;
        let v0 = GoldenKeyBurnEvent{nft_id: 0x2::object::id<GoldenKey>(&arg0)};
        0x2::event::emit<GoldenKeyBurnEvent>(v0);
        let GoldenKey {
            id     : v1,
            number : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun burn_minter_cap(arg0: MinterCap, arg1: &Version) {
        checkVersion(arg1, 2);
        let MinterCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun checkVersion(arg0: &Version, arg1: u64) {
        assert!(arg1 == arg0.version, 9223372500711374851);
    }

    public fun get_blacklisted_minters(arg0: &BlacklistedMinters) : vector<address> {
        arg0.minters
    }

    public fun get_burn_count(arg0: &GkSupply) : u64 {
        arg0.gk_burn_count
    }

    public fun get_total_supply(arg0: &GkSupply) : u64 {
        arg0.total_supply
    }

    fun init(arg0: GOLDEN_KEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GOLDEN_KEY>(arg0, arg1);
        let v1 = 0x2::display::new<GoldenKey>(&v0, arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = Version{
            id      : 0x2::object::new(arg1),
            version : 2,
        };
        let v4 = GkSupply{
            id            : 0x2::object::new(arg1),
            total_supply  : 0,
            gk_burn_count : 0,
        };
        let v5 = BlacklistedMinters{
            id      : 0x2::object::new(arg1),
            minters : 0x1::vector::empty<address>(),
        };
        0x2::display::add<GoldenKey>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Snoopy #{number}"));
        0x2::display::add<GoldenKey>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"This is a snoopy."));
        0x2::display::add<GoldenKey>(&mut v1, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<GoldenKey>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U"));
        0x2::display::update_version<GoldenKey>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<GoldenKey>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Version>(v3);
        0x2::transfer::share_object<GkSupply>(v4);
        0x2::transfer::share_object<BlacklistedMinters>(v5);
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut Version, arg2: u64) {
        assert!(arg2 > arg1.version, 9223372517891244035);
        arg1.version = arg2;
    }

    public fun mint_golden_key(arg0: &MinterCap, arg1: &Version, arg2: &mut GkSupply, arg3: &BlacklistedMinters, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        checkVersion(arg1, 2);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x1::vector::contains<address>(&arg3.minters, &v0), 9223372724049936391);
        let v1 = get_total_supply(arg2);
        assert!(v1 < 2000, 9223372736934445057);
        let v2 = GoldenKey{
            id     : 0x2::object::new(arg5),
            number : v1 + 1,
        };
        let v3 = MintGoldenKeyEvent{
            recipient : arg4,
            nft_id    : 0x2::object::id<GoldenKey>(&v2),
        };
        0x2::event::emit<MintGoldenKeyEvent>(v3);
        arg2.total_supply = arg2.total_supply + 1;
        0x2::transfer::public_transfer<GoldenKey>(v2, arg4);
    }

    public fun mint_minter_cap(arg0: &AdminCap, arg1: &Version, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        checkVersion(arg1, 2);
        let v0 = MinterCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<MinterCap>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

