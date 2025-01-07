module 0xfefd9c569ef1fe3d819286b0065cbdb0cf8375ff0dd75c73c54ca13cb5fa2325::manyu {
    struct MANYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANYU>(arg0, 6, b"MANYU", b"Manyu on Sui", x"4d414e5955203a20544845204d4f535420564952414c20444f47204f4e2054484520494e5445524e45540a54484520464952535420244d414e5955204f4e2053554920424c4f434b434841494e0a68747470733a2f2f7777772e74696b746f6b2e636f6d2f406c6974746c656d616e7975", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L7e_Go0t_R_400x400_407c66ca58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

