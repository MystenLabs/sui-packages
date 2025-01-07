module 0xf259087565e2b3b5720990d71738f4f3bcc47dc8d32469d45151f61c6f7e9d8c::trd {
    struct TRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRD>(arg0, 9, b"TRD", b"TRENDING ", b"We are Trending, the biggest coin in the social media market space, we bring you all the trending news and updates as we are forever up to trends, join our community, be the Trend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e9cee64-0d86-4fc6-9740-fe93226afee8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

