module 0x975d6ff6752c73b97227bb4541b878bc91fbb94a0249369a11179de9556bbe6b::kica {
    struct KICA has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KICA>, arg1: 0x2::coin::Coin<KICA>) {
        assert!(true == false, 100);
        0x2::coin::burn<KICA>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KICA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (true == true && 0x2::balance::supply_value<KICA>(0x2::coin::supply<KICA>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<KICA>>(0x2::coin::mint<KICA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KICA>(arg0, 9, b"KICA", b"KICATOKEN", b"Super Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/lINizrkkWfqspOPfS3TC6DkBpm3htoF0T_-XJftMrX8?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KICA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KICA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

