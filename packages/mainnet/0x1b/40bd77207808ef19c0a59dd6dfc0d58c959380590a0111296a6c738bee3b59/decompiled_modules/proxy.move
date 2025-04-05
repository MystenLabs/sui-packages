module 0x1b40bd77207808ef19c0a59dd6dfc0d58c959380590a0111296a6c738bee3b59::proxy {
    struct PROXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROXY>(arg0, 6, b"PROXY", b"Proxy", b"I'm a cat with lightning on my head", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054319_4b2f576d06.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PROXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

