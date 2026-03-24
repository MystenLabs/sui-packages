module 0xb7f77ca3ce1c554a4198268d6e4e80c6f7753b9d3dec85cb650feec1b1177764::bsgp {
    struct BSGP has drop {
        dummy_field: bool,
    }

    struct MintVault has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<BSGP>,
        total_minted: u64,
        admin: address,
    }

    entry fun mint(arg0: &mut MintVault, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(arg0.total_minted + arg1 <= 2147483647000000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BSGP>>(0x2::coin::mint<BSGP>(&mut arg0.treasury_cap, arg1, arg3), arg2);
        arg0.total_minted = arg0.total_minted + arg1;
    }

    fun init(arg0: BSGP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSGP>(arg0, 9, b"BSGP", b"Bubblescape GP", b"The universal game currency of the BUBLZ ecosystem. 2,147,483,647 max supply.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bublz.fun/bsgp.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSGP>>(v1);
        let v2 = MintVault{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
            total_minted : 0,
            admin        : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<MintVault>(v2);
    }

    public fun max_supply() : u64 {
        2147483647000000000
    }

    entry fun mint_batch(arg0: &mut MintVault, arg1: vector<u64>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        let v0 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 == 0x1::vector::length<address>(&arg2), 2);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v1);
            assert!(arg0.total_minted + v2 <= 2147483647000000000, 1);
            0x2::transfer::public_transfer<0x2::coin::Coin<BSGP>>(0x2::coin::mint<BSGP>(&mut arg0.treasury_cap, v2, arg3), *0x1::vector::borrow<address>(&arg2, v1));
            arg0.total_minted = arg0.total_minted + v2;
            v1 = v1 + 1;
        };
    }

    public fun remaining(arg0: &MintVault) : u64 {
        2147483647000000000 - arg0.total_minted
    }

    public fun total_minted(arg0: &MintVault) : u64 {
        arg0.total_minted
    }

    // decompiled from Move bytecode v6
}

