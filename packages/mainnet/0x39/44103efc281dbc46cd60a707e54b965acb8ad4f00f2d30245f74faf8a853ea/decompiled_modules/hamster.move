module 0x3944103efc281dbc46cd60a707e54b965acb8ad4f00f2d30245f74faf8a853ea::hamster {
    struct MintCap has store, key {
        id: 0x2::object::UID,
        mint_records: vector<address>,
        mint_counts: vector<u64>,
    }

    struct HAMSTER has drop {
        dummy_field: bool,
    }

    fun get_mint_count(arg0: &MintCap, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.mint_records)) {
            if (*0x1::vector::borrow<address>(&arg0.mint_records, v0) == arg1) {
                return *0x1::vector::borrow<u64>(&arg0.mint_counts, v0)
            };
            v0 = v0 + 1;
        };
        0
    }

    fun init(arg0: HAMSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMSTER>(arg0, 6, b"Hamster", b"Hamster", b"eep-eep-eep hamsters on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.pinata.cloud/ipfs/QmQgeb5N6DyXtuFve1nD7vbsU3pmvdadnUMsQDtFiptjBd"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAMSTER>(&mut v2, 360000000000000000 * 40 / 100, 0x2::tx_context::sender(arg1), arg1);
        let v3 = MintCap{
            id           : 0x2::object::new(arg1),
            mint_records : 0x1::vector::empty<address>(),
            mint_counts  : 0x1::vector::empty<u64>(),
        };
        0x2::transfer::public_share_object<MintCap>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSTER>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMSTER>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HAMSTER>, arg1: &mut MintCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 != arg2, 3);
        let v1 = get_mint_count(arg1, v0);
        assert!(v1 < 30, 1);
        let v2 = 100000000000 * 20 / 100;
        assert!(0x2::coin::total_supply<HAMSTER>(arg0) + 100000000000 + v2 <= 360000000000000000, 2);
        if (v1 == 0) {
            0x1::vector::push_back<address>(&mut arg1.mint_records, v0);
            0x1::vector::push_back<u64>(&mut arg1.mint_counts, 1);
        } else {
            let v3 = 0;
            while (v3 < 0x1::vector::length<address>(&arg1.mint_records)) {
                if (*0x1::vector::borrow<address>(&arg1.mint_records, v3) == v0) {
                    let v4 = 0x1::vector::borrow_mut<u64>(&mut arg1.mint_counts, v3);
                    *v4 = *v4 + 1;
                    break
                };
                v3 = v3 + 1;
            };
        };
        0x2::coin::mint_and_transfer<HAMSTER>(arg0, 100000000000, v0, arg3);
        0x2::coin::mint_and_transfer<HAMSTER>(arg0, v2, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

