module 0xbae234119eacc73dbacc44dbf1deb238d72a8a4c7a28aaed433453f5d0e0d7cd::cc {
    struct CC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CC>(arg0, 9, b"CC", b"Mechomutant Gnashtail", b"cartoon chaos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3863bbc8f30ba9c3fa712200fadccca0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

