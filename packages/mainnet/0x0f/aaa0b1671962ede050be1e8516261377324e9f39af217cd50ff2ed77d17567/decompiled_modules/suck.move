module 0xfaaa0b1671962ede050be1e8516261377324e9f39af217cd50ff2ed77d17567::suck {
    struct SUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCK>(arg0, 6, b"SUCK", b"SUCK On Sui", b" Quackin and stackin in the crypto world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1e0c6b1bf754dc82ebeda65bc03084ed_fe5be70f10.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

