module 0x52464f8f1b1abe6476653b728d660086d3f8763b943de51a71a00795b67aacb5::cubic {
    struct CUBIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUBIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUBIC>(arg0, 9, b"CUB", b"CUBICn", b"Cubic Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static-file.cubicgames.xyz/cubic_icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUBIC>>(v1);
        0x2::coin::mint_and_transfer<CUBIC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUBIC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

