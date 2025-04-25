module 0x550bd233f561330b1350b86c2ae6213ca26940af6c94b8a633e6f0f4d0335f56::rise {
    struct RISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RISE>(arg0, 6, b"RISE", b"RISE YOUR HAND TO MOON", b"TEXAS IS DOGSHIT HE IS SCUMBAG AS DEV. QUIT CRYPTO DOG CUNT IDIOT ASSHOLE TEXAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidqgkwgkslwto5lifnx7dualsfmusgiufla7vkjs6hfzk3y44bgdm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RISE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

