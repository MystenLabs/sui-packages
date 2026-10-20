module 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::pass {
    struct PassMint has key {
        id: 0x2::object::UID,
        version: u64,
        on: bool,
        minter: 0x2::object::ID,
        day_limit: u64,
        day: u64,
        minted_today: u64,
        skins: 0x2::table::Table<0x1::string::String, Skin>,
    }

    struct Skin has drop, store {
        key: 0x1::string::String,
        name: 0x1::string::String,
        kind: 0x1::string::String,
        design: 0x1::string::String,
        colourway: 0x1::string::String,
        rarity: 0x1::string::String,
        edition: 0x1::string::String,
        description: 0x1::string::String,
        cap: u64,
        minted: u64,
    }

    struct MinterCap has key {
        id: 0x2::object::UID,
    }

    struct SkinMinted has copy, drop {
        item: 0x2::object::ID,
        skin: 0x1::string::String,
        key: 0x1::string::String,
        copy_id: 0x1::string::String,
        owner: address,
    }

    struct MinterChanged has copy, drop {
        minter: 0x2::object::ID,
        holder: address,
    }

    public fun add_skin(arg0: &mut PassMint, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: u64) {
        assert!(arg0.version == 4, 13906834883013115907);
        assert!(!0x2::table::contains<0x1::string::String, Skin>(&arg0.skins, arg2), 13906834887308738573);
        let v0 = Skin{
            key         : arg3,
            name        : arg4,
            kind        : arg5,
            design      : arg6,
            colourway   : arg7,
            rarity      : arg8,
            edition     : arg9,
            description : arg10,
            cap         : arg11,
            minted      : 0,
        };
        0x2::table::add<0x1::string::String, Skin>(&mut arg0.skins, arg2, v0);
    }

    public fun day_limit(arg0: &PassMint) : u64 {
        arg0.day_limit
    }

    public fun has_skin(arg0: &PassMint, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, Skin>(&arg0.skins, arg1)
    }

    public fun is_on(arg0: &PassMint) : bool {
        arg0.on
    }

    public fun migrate(arg0: &mut PassMint, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap) {
        assert!(arg0.version < 4, 13906834977502527493);
        arg0.version = 4;
    }

    public fun mint(arg0: &mut PassMint, arg1: &MinterCap, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        mint_one(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun mint_one(arg0: &mut PassMint, arg1: &MinterCap, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 4, 13906835209430630403);
        assert!(arg0.on, 13906835213725859847);
        assert!(0x2::object::id<MinterCap>(arg1) == arg0.minter, 13906835218020958217);
        assert!(arg3 <= 999999, 13906835222316711957);
        assert!(0x2::table::contains<0x1::string::String, Skin>(&arg0.skins, arg2), 13906835226611023883);
        let v0 = 0x2::clock::timestamp_ms(arg6) / 86400000;
        if (v0 != arg0.day) {
            arg0.day = v0;
            arg0.minted_today = 0;
        };
        assert!(arg0.day_limit == 0 || arg0.minted_today < arg0.day_limit, 13906835252381351955);
        arg0.minted_today = arg0.minted_today + 1;
        let v1 = 0x2::table::borrow_mut<0x1::string::String, Skin>(&mut arg0.skins, arg2);
        assert!(v1.cap == 0 || v1.minted < v1.cap, 13906835265266122769);
        v1.minted = v1.minted + 1;
        let v2 = 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::new(v1.name, v1.kind, v1.design, v1.colourway, v1.rarity, v1.edition, v1.description, v1.key, 0, 0, arg3, arg7);
        let v3 = SkinMinted{
            item    : 0x2::object::id<0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::Item>(&v2),
            skin    : arg2,
            key     : v1.key,
            copy_id : arg5,
            owner   : arg4,
        };
        0x2::event::emit<SkinMinted>(v3);
        0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::universe::deliver(v2, arg4);
    }

    entry fun mint_rolled(arg0: &mut PassMint, arg1: &MinterCap, arg2: vector<0x1::string::String>, arg3: vector<address>, arg4: vector<0x1::string::String>, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(0x1::vector::length<address>(&arg3) == v0 && 0x1::vector::length<0x1::string::String>(&arg4) == v0, 13906835123532595223);
        let v1 = 0x2::random::new_generator(arg5, arg7);
        let v2 = 0;
        while (v2 < v0) {
            mint_one(arg0, arg1, *0x1::vector::borrow<0x1::string::String>(&arg2, v2), 0x2::random::generate_u64_in_range(&mut v1, 0, 999999), *0x1::vector::borrow<address>(&arg3, v2), *0x1::vector::borrow<0x1::string::String>(&arg4, v2), arg6, arg7);
            v2 = v2 + 1;
        };
    }

    public fun minted_today(arg0: &PassMint, arg1: &0x2::clock::Clock) : u64 {
        if (0x2::clock::timestamp_ms(arg1) / 86400000 == arg0.day) {
            arg0.minted_today
        } else {
            0
        }
    }

    public fun minter(arg0: &PassMint) : 0x2::object::ID {
        arg0.minter
    }

    public fun new_minter(arg0: &mut PassMint, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 4, 13906834745574162435);
        let v0 = MinterCap{id: 0x2::object::new(arg3)};
        arg0.minter = 0x2::object::id<MinterCap>(&v0);
        let v1 = MinterChanged{
            minter : 0x2::object::id<MinterCap>(&v0),
            holder : arg2,
        };
        0x2::event::emit<MinterChanged>(v1);
        0x2::transfer::transfer<MinterCap>(v0, arg2);
    }

    public fun remove_skin(arg0: &mut PassMint, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg2: 0x1::string::String) {
        assert!(arg0.version == 4, 13906834943142658051);
        assert!(0x2::table::contains<0x1::string::String, Skin>(&arg0.skins, arg2), 13906834947438149643);
        assert!(0x2::table::borrow<0x1::string::String, Skin>(&arg0.skins, arg2).minted == 0, 13906834951733379087);
        0x2::table::remove<0x1::string::String, Skin>(&mut arg0.skins, arg2);
    }

    public fun set_day_limit(arg0: &mut PassMint, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg2: u64) {
        assert!(arg0.version == 4, 13906834801408737283);
        arg0.day_limit = arg2;
    }

    public fun set_on(arg0: &mut PassMint, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg2: bool) {
        assert!(arg0.version == 4, 13906834779933900803);
        arg0.on = arg2;
    }

    public fun set_skin_cap(arg0: &mut PassMint, arg1: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg2: 0x1::string::String, arg3: u64) {
        assert!(arg0.version == 4, 13906834913077886979);
        assert!(0x2::table::contains<0x1::string::String, Skin>(&arg0.skins, arg2), 13906834917373378571);
        0x2::table::borrow_mut<0x1::string::String, Skin>(&mut arg0.skins, arg2).cap = arg3;
    }

    public fun setup(arg0: &0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::item::AdminCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MinterCap{id: 0x2::object::new(arg3)};
        let v1 = PassMint{
            id           : 0x2::object::new(arg3),
            version      : 4,
            on           : true,
            minter       : 0x2::object::id<MinterCap>(&v0),
            day_limit    : arg2,
            day          : 0,
            minted_today : 0,
            skins        : 0x2::table::new<0x1::string::String, Skin>(arg3),
        };
        let v2 = MinterChanged{
            minter : 0x2::object::id<MinterCap>(&v0),
            holder : arg1,
        };
        0x2::event::emit<MinterChanged>(v2);
        0x2::transfer::share_object<PassMint>(v1);
        0x2::transfer::transfer<MinterCap>(v0, arg1);
    }

    public fun skin_cap(arg0: &PassMint, arg1: 0x1::string::String) : u64 {
        0x2::table::borrow<0x1::string::String, Skin>(&arg0.skins, arg1).cap
    }

    public fun skin_edition(arg0: &PassMint, arg1: 0x1::string::String) : 0x1::string::String {
        0x2::table::borrow<0x1::string::String, Skin>(&arg0.skins, arg1).edition
    }

    public fun skin_key(arg0: &PassMint, arg1: 0x1::string::String) : 0x1::string::String {
        0x2::table::borrow<0x1::string::String, Skin>(&arg0.skins, arg1).key
    }

    public fun skin_minted(arg0: &PassMint, arg1: 0x1::string::String) : u64 {
        0x2::table::borrow<0x1::string::String, Skin>(&arg0.skins, arg1).minted
    }

    public fun version(arg0: &PassMint) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

