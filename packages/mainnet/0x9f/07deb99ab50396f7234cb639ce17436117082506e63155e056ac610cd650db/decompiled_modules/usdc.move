module 0x9f07deb99ab50396f7234cb639ce17436117082506e63155e056ac610cd650db::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"USDC", b"UNITED SUI DEGEN CHAIN", b"USDC is a digital chain, that is fully backed by Sui Degens and Sui Hodlers. USDC was developed to represent a US Dollar equivalent chain, but even better. Used to send to the MOON, store, and receive money between people and businesses without the need for third-party financial institutions via swap with Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_vibrant_USDC_logo_sits_prominently_on_a_bri_2_1a3c9d0db3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

