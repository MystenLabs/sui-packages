module 0x8a3864f5f5363a290aecfd1ac0338de57aa0f170933a470b54591ad8fa9a47bc::king {
    struct KING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING>(arg0, 6, b"KING", b"King", b"It's good to be the king.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734462247491.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

