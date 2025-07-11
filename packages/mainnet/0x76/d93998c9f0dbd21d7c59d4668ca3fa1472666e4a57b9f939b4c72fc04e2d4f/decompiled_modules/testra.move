module 0x76d93998c9f0dbd21d7c59d4668ca3fa1472666e4a57b9f939b4c72fc04e2d4f::testra {
    struct TESTRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTRA>(arg0, 6, b"Testra", b"Test", b"Ajshd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidztykepkaqt6plawx364j35zwfcbmxhyapgp44jzmupjotxz2aca")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

