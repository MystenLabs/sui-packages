module 0xada0a98d7e3ce01ac7bcb9aa3384e24a5943c7cd8ce2ffe5e1eac6ff49b26853::suihole {
    struct SUIHOLE has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIHOLE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIHOLE>>(0x2::coin::mint<SUIHOLE>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SUIHOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHOLE>(arg0, 9, b"SUIHOLE", b"SUIHOLE", b"Just releasing hot water...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1350829743327776768/6nyGURem_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIHOLE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIHOLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHOLE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

