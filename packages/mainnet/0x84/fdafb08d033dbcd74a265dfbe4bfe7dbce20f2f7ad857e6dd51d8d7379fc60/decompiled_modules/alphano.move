module 0x84fdafb08d033dbcd74a265dfbe4bfe7dbce20f2f7ad857e6dd51d8d7379fc60::alphano {
    struct ALPHANO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHANO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ALPHANO>(arg0, 6, b"ALPHANO", b"Alphanochaint", b"Your go-to ai agent for real-time on-chain metrics, emerging crypto  trends, hot narratives across ecosystems. Stay ahead in the crypto space with actionable insights and even influential hot news", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_20241231_195538_600_20f517797d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALPHANO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHANO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

