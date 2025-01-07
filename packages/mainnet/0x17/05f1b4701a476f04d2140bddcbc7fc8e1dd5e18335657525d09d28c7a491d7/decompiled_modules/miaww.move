module 0x1705f1b4701a476f04d2140bddcbc7fc8e1dd5e18335657525d09d28c7a491d7::miaww {
    struct MIAWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAWW>(arg0, 9, b"MIAWW", b"Miaw Miaw ", b"Just token not rug not dump if u trust u winner", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6bc3f5d1c6f4081a154828f334603238blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIAWW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAWW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

