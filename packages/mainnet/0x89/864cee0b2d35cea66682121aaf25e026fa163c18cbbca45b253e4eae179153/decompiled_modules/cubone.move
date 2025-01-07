module 0x89864cee0b2d35cea66682121aaf25e026fa163c18cbbca45b253e4eae179153::cubone {
    struct CUBONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUBONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUBONE>(arg0, 6, b"CUBONE", b"CUBONE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cubone.xyz/cubone.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUBONE>>(v1);
        0x2::coin::mint_and_transfer<CUBONE>(&mut v2, 5000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUBONE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

