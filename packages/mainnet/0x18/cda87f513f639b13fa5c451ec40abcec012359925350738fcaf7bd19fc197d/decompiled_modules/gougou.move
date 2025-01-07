module 0x18cda87f513f639b13fa5c451ec40abcec012359925350738fcaf7bd19fc197d::gougou {
    struct GOUGOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOUGOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOUGOU>(arg0, 6, b"GOUGOU", b"Chinese Doge", b"Doge Coin in Chinese is written as  (gu gu b) GOUGOU Token merges the beloved Doge meme with the charm of Chinese cultural elements, resulting in a refreshing and captivating synthesis that pays homage to tradition while embracing the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pprn_logo_9c79b22e25.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOUGOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOUGOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

