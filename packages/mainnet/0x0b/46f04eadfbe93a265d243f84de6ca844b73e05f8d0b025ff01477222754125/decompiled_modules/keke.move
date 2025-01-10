module 0xb46f04eadfbe93a265d243f84de6ca844b73e05f8d0b025ff01477222754125::keke {
    struct KEKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKE>(arg0, 9, b"KEKE", b"KEKE on SUI", b"Hi-ho! Im KEKE. Im green and it will be fine. Welcome to the official Twitter of me, $keke the Frog!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x69000b169ba9fcf72b6a05385d4239d79f5ae299.png?size=xl&key=d9bc7a")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KEKE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

