module 0x66e303afc783c50e634bdc177ef32d4675d69b0a6aecde39f09d0b2a5f9f1147::wsui {
    struct WSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSUI>(arg0, 9, b"WSUI", b"WSui Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSUI>>(v0, @0x8635a944b059f419f54fa878270e310af8151249018ff3d26ec7b07c361041b1);
    }

    // decompiled from Move bytecode v6
}

