module 0x32c0758ecda51324dc836228f8e25f70347b4e275cc35d7f1076afa9256ce079::suima {
    struct SUIMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMA>(arg0, 9, b"SUIMA", b"SUIMA DUCK", b"Duck duck swim", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e3fe0b7c74449c85cf0a106097c20fa7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

