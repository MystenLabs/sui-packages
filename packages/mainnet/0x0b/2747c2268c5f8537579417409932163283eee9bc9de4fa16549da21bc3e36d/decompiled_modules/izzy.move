module 0xb2747c2268c5f8537579417409932163283eee9bc9de4fa16549da21bc3e36d::izzy {
    struct IZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: IZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IZZY>(arg0, 6, b"IZZY", b"IZZY ON SUI", b"Next trending on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_23_5eb8b62279.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

