module 0xb76e682519d72ec9302b78bf206a18aba526eb6ff034c69d22f8e1909c39d075::gallagher {
    struct GALLAGHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GALLAGHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GALLAGHER>(arg0, 6, b"Gallagher", b"Dan Gallagher", x"4368616972206f662074686520552e532e205365637572697469657320616e642045786368616e676520436f6d6d697373696f6e2e0a54686520626567696e6e696e67206f66206120677265617420686973746f7279206f662063727970746f2066696e616e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731053363027.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GALLAGHER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GALLAGHER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

