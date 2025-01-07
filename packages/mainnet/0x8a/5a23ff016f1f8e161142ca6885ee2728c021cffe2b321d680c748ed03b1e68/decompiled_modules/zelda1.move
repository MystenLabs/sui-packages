module 0x8a5a23ff016f1f8e161142ca6885ee2728c021cffe2b321d680c748ed03b1e68::zelda1 {
    struct ZELDA1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZELDA1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZELDA1>(arg0, 6, b"ZELDA1", b"ZELDA", b"ZELDA1 KAT'S ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_27_fbc0fc6be0_4a60741eae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZELDA1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZELDA1>>(v1);
    }

    // decompiled from Move bytecode v6
}

