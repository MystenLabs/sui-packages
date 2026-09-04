module 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::resource_forge {
    struct ForgeAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ForgeConfig has key {
        id: 0x2::object::UID,
        authority: address,
        forged: u64,
        media_base: 0x1::string::String,
    }

    struct WeaponForged has copy, drop {
        weapon_id: 0x2::object::ID,
        recipient: address,
        kind: u8,
        serial: u64,
        provenance: 0x1::string::String,
    }

    public fun authority(arg0: &ForgeConfig) : address {
        arg0.authority
    }

    public fun forge_from_core(arg0: &mut ForgeConfig, arg1: 0x80febc8885804d47c9dfdb08a78d21811fb54d1972418211d709da4937a0d8b2::core::PrimeCore, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x80febc8885804d47c9dfdb08a78d21811fb54d1972418211d709da4937a0d8b2::core::consume_receipt(0x80febc8885804d47c9dfdb08a78d21811fb54d1972418211d709da4937a0d8b2::core::burn_for_lance(arg1, arg2));
        let v3 = v1;
        let v4 = 0x1::string::utf8(b"forged from Prime Core #");
        0x1::string::append(&mut v4, 0x1::u64::to_string(v0));
        if (!0x1::string::is_empty(&v3)) {
            0x1::string::append(&mut v4, 0x1::string::utf8(b", struck in "));
            0x1::string::append(&mut v4, v3);
        };
        let v5 = mint_forged(arg0, 8, v4, arg2);
        0x2::transfer::public_transfer<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(v5, v2);
        let v6 = WeaponForged{
            weapon_id  : 0x2::object::id<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(&v5),
            recipient  : v2,
            kind       : 8,
            serial     : arg0.forged,
            provenance : v4,
        };
        0x2::event::emit<WeaponForged>(v6);
    }

    entry fun forge_mint(arg0: &mut ForgeConfig, arg1: u8, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.authority, 1);
        assert!(arg1 == 7 || arg1 == 8, 2);
        let v0 = mint_forged(arg0, arg1, arg3, arg4);
        0x2::transfer::public_transfer<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(v0, arg2);
        let v1 = WeaponForged{
            weapon_id  : 0x2::object::id<0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon>(&v0),
            recipient  : arg2,
            kind       : arg1,
            serial     : arg0.forged,
            provenance : arg3,
        };
        0x2::event::emit<WeaponForged>(v1);
    }

    public fun forged(arg0: &ForgeConfig) : u64 {
        arg0.forged
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = ForgeAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ForgeAdminCap>(v1, v0);
        let v2 = ForgeConfig{
            id         : 0x2::object::new(arg0),
            authority  : v0,
            forged     : 0,
            media_base : 0x1::string::utf8(b""),
        };
        0x2::transfer::share_object<ForgeConfig>(v2);
    }

    fun mint_forged(arg0: &mut ForgeConfig, arg1: u8, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::Weapon {
        arg0.forged = arg0.forged + 1;
        let v0 = arg0.forged;
        let v1 = if (arg1 == 7) {
            0x1::string::utf8(b"Boomdust Mortar #")
        } else {
            0x1::string::utf8(b"Old-World Lance #")
        };
        let v2 = v1;
        0x1::string::append(&mut v2, 0x1::u64::to_string(v0));
        let v3 = arg0.media_base;
        if (arg1 == 7) {
            0x1::string::append(&mut v3, 0x1::string::utf8(b"boomdust-mortar.png"));
        } else {
            0x1::string::append(&mut v3, 0x1::string::utf8(b"relic.png"));
        };
        let v4 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v4, 0x1::string::utf8(b"KIND"), 0x1::u64::to_string((arg1 as u64)));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v4, 0x1::string::utf8(b"FORGED"), 0x1::string::utf8(b"true"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v4, 0x1::string::utf8(b"PROVENANCE"), arg2);
        let v5 = if (arg1 == 7) {
            0x1::string::utf8(x"536965676520617274696c6c65727920666f726765642066726f6d207468652057617374657327206f776e20626f6e657320e280942073637261702c20616c6c6f7920616e6420626f6f6d64757374206e6f20637261746520657665722068656c642e")
        } else {
            0x1::string::utf8(b"A weapon of the old world, remade around a Prime Core. Crates cannot roll this. Mining found it.")
        };
        0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::weapon::mint(arg1, 4, v0, v2, v5, v3, v4, arg3)
    }

    public fun set_authority(arg0: &ForgeAdminCap, arg1: &mut ForgeConfig, arg2: address) {
        arg1.authority = arg2;
    }

    public fun set_media_base(arg0: &ForgeAdminCap, arg1: &mut ForgeConfig, arg2: 0x1::string::String) {
        arg1.media_base = arg2;
    }

    // decompiled from Move bytecode v7
}

