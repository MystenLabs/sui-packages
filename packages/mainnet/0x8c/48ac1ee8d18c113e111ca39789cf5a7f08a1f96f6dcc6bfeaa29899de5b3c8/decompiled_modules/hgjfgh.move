module 0x8c48ac1ee8d18c113e111ca39789cf5a7f08a1f96f6dcc6bfeaa29899de5b3c8::hgjfgh {
    struct HGJFGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HGJFGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HGJFGH>(arg0, 9, b"HGJFGH", b"ASDASD", b"SDFGSF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eca8cf2b-37e6-4e55-b90d-d9b37bf20a2f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HGJFGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HGJFGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

