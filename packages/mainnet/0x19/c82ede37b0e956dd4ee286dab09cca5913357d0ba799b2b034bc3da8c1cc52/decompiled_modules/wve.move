module 0x19c82ede37b0e956dd4ee286dab09cca5913357d0ba799b2b034bc3da8c1cc52::wve {
    struct WVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WVE>(arg0, 5, b"WVE", b"Wave", b"Testing out the Sui Waves ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

