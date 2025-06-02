module 0x35dc82f140329e1c8c316f1b983da81b7ed7637fbacca73983d5063334388386::sgod {
    struct SGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOD>(arg0, 6, b"SGOD", b"SUI GOD", b"SGOD, IS THE GOD OF SUI. $SGOD UNDERSTAND AND FEEL THE SUFFERING OF RUG VICTIMS. \"OO MY SON, SGOD IS PREPARED TO MAKE REDEMPTION BY BRINGING YOU ALL TO THE MOON.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig5wokwpt44wo34gq4osmepyjlvfqahlw2duzik2sb3fceoheet5u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SGOD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

