module 0x60686d1255e8cafff19b98d07b4960d723b0c11d983636718e6a609ff1ed6064::sqd {
    struct SQD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQD>(arg0, 6, b"SQD", b"Squid", b"Eight arms, one goal  to grab every bit of crypto treasure in the deep seas of DeFi! SuiSquid will ink out the competition and hold on tight to your bags.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ai_image_eff83e5930.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQD>>(v1);
    }

    // decompiled from Move bytecode v6
}

