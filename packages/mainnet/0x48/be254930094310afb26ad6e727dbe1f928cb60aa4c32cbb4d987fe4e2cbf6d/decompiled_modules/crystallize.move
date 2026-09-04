module 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::crystallize {
    struct CrystallizeRegistry has key {
        id: 0x2::object::UID,
        consumed: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct Crystallized has copy, drop {
        ghost_id: 0x2::object::ID,
        new_object_id: 0x2::object::ID,
        keeper: address,
        creator: address,
        royalty_bps: u16,
        kind: u8,
        date_yyyymmdd: u64,
        tvyn_burned: u64,
        timestamp_ms: u64,
    }

    public entry fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CrystallizeRegistry{
            id       : 0x2::object::new(arg0),
            consumed : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<CrystallizeRegistry>(v0);
    }

    public entry fun crystallize_ghost(arg0: 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::GhostMemory, arg1: u8, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::TVYN>, arg7: &mut CrystallizeRegistry, arg8: &mut 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::MintVault, arg9: &0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::Config, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        assert!(arg1 == 1 || arg1 == 2, 302);
        assert!(0x2::coin::value<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::TVYN>(&arg6) >= 10000000, 303);
        assert!(0x2::object::id<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::MintVault>(arg8) == 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::config_registry::mint_vault_id(arg9), 305);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 306);
        let v1 = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::id(&arg0);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg7.consumed, v1), 304);
        0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::burn_for_protocol(arg8, arg6);
        let v2 = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::creator(&arg0);
        let v3 = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::royalty_bps(&arg0);
        let v4 = if (arg1 == 1) {
            let v5 = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::mint_ticket(arg2, arg3, arg4, arg5, v2, v3, false, 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::created_at_ms(&arg0), arg11);
            let v6 = 0x2::object::id<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::Today365>(&v5);
            0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg7.consumed, v1, v6);
            0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::destroy(arg0);
            0x2::transfer::public_transfer<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::anniversary_vault::Today365>(v5, v0);
            v6
        } else {
            let v7 = 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::mint_ticket(((arg2 / 10000) as u16), arg3, arg4, arg5, v2, v3, 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::created_at_ms(&arg0), arg11);
            let v8 = 0x2::object::id<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::NostalgiaTicket>(&v7);
            0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg7.consumed, v1, v8);
            0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::ghost_memory::destroy(arg0);
            0x2::transfer::public_transfer<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::nostalgia_ticket::NostalgiaTicket>(v7, v0);
            v8
        };
        let v9 = Crystallized{
            ghost_id      : v1,
            new_object_id : v4,
            keeper        : v0,
            creator       : v2,
            royalty_bps   : v3,
            kind          : arg1,
            date_yyyymmdd : arg2,
            tvyn_burned   : 0x2::coin::value<0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::tvyn::TVYN>(&arg6),
            timestamp_ms  : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<Crystallized>(v9);
    }

    // decompiled from Move bytecode v7
}

