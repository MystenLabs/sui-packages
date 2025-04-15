module 0xaa2939844ba97b80e3c0a8fe91afb60e2b2208a3df8cb8a4e6b4f3096dc5652::hhodl {
    struct HHODL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHODL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHODL>(arg0, 9, b"HHODL", b"Hodl", b"Hodl is a meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/47c7ce79c999d64faea25a06ba314667blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHODL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHODL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

