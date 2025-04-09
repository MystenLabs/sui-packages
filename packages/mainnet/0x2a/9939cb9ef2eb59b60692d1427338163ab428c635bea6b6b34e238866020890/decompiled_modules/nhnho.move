module 0x2a9939cb9ef2eb59b60692d1427338163ab428c635bea6b6b34e238866020890::nhnho {
    struct NHNHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NHNHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NHNHO>(arg0, 9, b"NHNHO", b"NHANHO", b"I am a Nhanho fanho. I love to sock COKS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4fd68a1d8b607aea31e51ab70c975f3dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NHNHO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NHNHO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

