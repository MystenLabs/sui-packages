module 0xd84576e9e1b2ad80c8774fdac4459b2c4fd4634b80546a5c2c8d467c6da6056d::sha {
    struct SHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHA>(arg0, 9, b"SHA", b"Sharking ", b"2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65559b61-3260-4e93-9faa-3610a264135b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

