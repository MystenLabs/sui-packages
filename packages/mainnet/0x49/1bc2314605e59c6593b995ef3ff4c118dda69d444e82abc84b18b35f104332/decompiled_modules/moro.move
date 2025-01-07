module 0x491bc2314605e59c6593b995ef3ff4c118dda69d444e82abc84b18b35f104332::moro {
    struct MORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORO>(arg0, 9, b"Moro", b"morocco", b"GRAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a16297688bd06a54dcf48316310ca814blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MORO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

