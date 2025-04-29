module 0x6bad6f31db90d245c72956b7344c3e1b5631a9c76f2942b16d8a7284f0c619bf::xsty {
    struct XSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSTY>(arg0, 9, b"XSty", b"DB HOT", b"Nightly For Hot Girls Lady to see hot ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/567e384b140391c519910f1ee285f085blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XSTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XSTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

