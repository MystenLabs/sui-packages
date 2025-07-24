module 0x22bec55bbebc49e46154ed9620a904b18da50bcba72fe66e500da53ca2cf298::catbtc {
    struct CATBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBTC>(arg0, 6, b"CATBTC", b"Crypto Cat", b"Crypto Cat Hodl BTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cc2_59c29ae9b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

