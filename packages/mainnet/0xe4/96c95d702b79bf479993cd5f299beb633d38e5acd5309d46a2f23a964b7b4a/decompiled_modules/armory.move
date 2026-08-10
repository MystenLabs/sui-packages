module 0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::armory {
    struct Blade has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        quality: u64,
        smith: 0x2::object::ID,
        smith_name: 0x1::string::String,
        forged_epoch: u64,
    }

    struct BladeForged has copy, drop {
        blade: 0x2::object::ID,
        smith: 0x2::object::ID,
        quality: u64,
        cost: u64,
    }

    struct ForgeTicket has store, key {
        id: 0x2::object::UID,
        smith: 0x2::object::ID,
        quality: u64,
        blade_name: 0x1::string::String,
    }

    struct TicketIssued has copy, drop {
        ticket: 0x2::object::ID,
        smith: 0x2::object::ID,
        quality: u64,
    }

    public fun blade_quality(arg0: u64) : u64 {
        let v0 = 10 + arg0 / 100;
        if (v0 > 100) {
            100
        } else {
            v0
        }
    }

    public fun cost() : u64 {
        250
    }

    public fun forge_blade(arg0: &mut 0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::koku::Vault, arg1: &mut 0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::samurai::Samurai, arg2: 0x2::coin::Coin<0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::koku::KOKU>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Blade {
        assert!(0x2::tx_context::sender(arg4) == 0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::samurai::owner(arg1), 0);
        assert!(0x2::coin::value<0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::koku::KOKU>(&arg2) == 250, 1);
        let v0 = blade_quality(0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::samurai::forge_xp(arg1));
        0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::koku::burn(arg0, arg2);
        0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::samurai::note_blade_forged(arg1);
        let v1 = Blade{
            id           : 0x2::object::new(arg4),
            name         : arg3,
            quality      : v0,
            smith        : 0x2::object::id<0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::samurai::Samurai>(arg1),
            smith_name   : 0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::samurai::name(arg1),
            forged_epoch : 0x2::tx_context::epoch(arg4),
        };
        let v2 = BladeForged{
            blade   : 0x2::object::id<Blade>(&v1),
            smith   : 0x2::object::id<0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::samurai::Samurai>(arg1),
            quality : v0,
            cost    : 250,
        };
        0x2::event::emit<BladeForged>(v2);
        v1
    }

    public fun forge_with_ticket(arg0: &mut 0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::koku::Vault, arg1: &mut 0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::samurai::Samurai, arg2: ForgeTicket, arg3: 0x2::coin::Coin<0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::koku::KOKU>, arg4: &mut 0x2::tx_context::TxContext) : Blade {
        assert!(0x2::tx_context::sender(arg4) == 0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::samurai::owner(arg1), 0);
        let ForgeTicket {
            id         : v0,
            smith      : v1,
            quality    : v2,
            blade_name : v3,
        } = arg2;
        assert!(v1 == 0x2::object::id<0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::samurai::Samurai>(arg1), 2);
        assert!(0x2::coin::value<0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::koku::KOKU>(&arg3) == 250, 1);
        0x2::object::delete(v0);
        0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::koku::burn(arg0, arg3);
        0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::samurai::note_blade_forged(arg1);
        let v4 = Blade{
            id           : 0x2::object::new(arg4),
            name         : v3,
            quality      : v2,
            smith        : v1,
            smith_name   : 0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::samurai::name(arg1),
            forged_epoch : 0x2::tx_context::epoch(arg4),
        };
        let v5 = BladeForged{
            blade   : 0x2::object::id<Blade>(&v4),
            smith   : v1,
            quality : v2,
            cost    : 250,
        };
        0x2::event::emit<BladeForged>(v5);
        v4
    }

    public fun issue_ticket(arg0: &0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::samurai::GameCap, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ForgeTicket{
            id         : 0x2::object::new(arg5),
            smith      : arg1,
            quality    : arg2,
            blade_name : arg3,
        };
        let v1 = TicketIssued{
            ticket  : 0x2::object::id<ForgeTicket>(&v0),
            smith   : arg1,
            quality : arg2,
        };
        0x2::event::emit<TicketIssued>(v1);
        0x2::transfer::public_transfer<ForgeTicket>(v0, arg4);
    }

    public fun quality(arg0: &Blade) : u64 {
        arg0.quality
    }

    // decompiled from Move bytecode v7
}

