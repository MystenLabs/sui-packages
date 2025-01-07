module 0x55c3eca06dc2b3abee8464c231fbfbe81abb83a3f18ad0bef7122caae9225911::non {
    struct NON has drop {
        dummy_field: bool,
    }

    fun init(arg0: NON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NON>(arg0, 9, b"NON", b"noon", x"656e737572696e6720796f757220696e766573746d656e74732061726520616c7761797320696e207468652073706f746c696768742077697468207065616b2070726f6669747320e29880efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d860b0e-e4ac-486a-953f-32340c33514c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NON>>(v1);
    }

    // decompiled from Move bytecode v6
}

