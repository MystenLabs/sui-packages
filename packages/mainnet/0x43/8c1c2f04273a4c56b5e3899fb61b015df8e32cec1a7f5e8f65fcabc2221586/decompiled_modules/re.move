module 0x438c1c2f04273a4c56b5e3899fb61b015df8e32cec1a7f5e8f65fcabc2221586::re {
    struct RE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RE>(arg0, 9, b"Re", b"Reborn", b"RICH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9686d1d323b8a1a186e6b89f361c0215blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

