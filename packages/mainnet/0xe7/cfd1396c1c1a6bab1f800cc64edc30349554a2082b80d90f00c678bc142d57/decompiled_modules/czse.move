module 0xe7cfd1396c1c1a6bab1f800cc64edc30349554a2082b80d90f00c678bc142d57::czse {
    struct CZSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZSE>(arg0, 9, b"CZSE", b"Smile", b"CZ in spring for smile.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/67c88caa14d9c9dbbcb5a8d1752e2858blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CZSE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZSE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

