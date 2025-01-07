module 0xd3b66de6ef040a741d1dde2cb5fba6db6d426b799f34a7fd66a999a23846c9e0::cybercat {
    struct CYBERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBERCAT>(arg0, 9, b"CYBERCAT", b"Cyber cat", b"Cyber cat is a good and profitable token, it can be used by anyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe44b994-7245-4475-9fa7-1b66a7a45327.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBERCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYBERCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

