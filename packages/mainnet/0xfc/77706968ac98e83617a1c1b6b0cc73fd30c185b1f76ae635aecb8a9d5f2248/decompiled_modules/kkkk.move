module 0xfc77706968ac98e83617a1c1b6b0cc73fd30c185b1f76ae635aecb8a9d5f2248::kkkk {
    struct KKKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKKK>(arg0, 9, b"KKKK", b"kkkk", b"kkkksss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KKKK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKKK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

