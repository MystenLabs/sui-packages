module 0x67f076f12100a13432310d8e4d2f6c2cce536deb44975bc04cd9ebcb4618b8fc::tom {
    struct TOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOM>(arg0, 9, b"TOM", b"$TOM", x"546f6d2026204a6572727920c2a9efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9f8901fc9db03e1d75e4d2f1f8aebff6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

