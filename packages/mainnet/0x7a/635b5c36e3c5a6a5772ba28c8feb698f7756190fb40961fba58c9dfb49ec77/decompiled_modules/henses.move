module 0x7a635b5c36e3c5a6a5772ba28c8feb698f7756190fb40961fba58c9dfb49ec77::henses {
    struct HENSES has drop {
        dummy_field: bool,
    }

    fun init(arg0: HENSES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HENSES>(arg0, 6, b"HENSES", b"henses", b"hen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<HENSES>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<HENSES>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

