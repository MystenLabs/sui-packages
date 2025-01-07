module 0x4f3f96bcf21f85846b7864c8fb0545b079069ef62924018332470c3f216353e9::igor {
    struct IGOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: IGOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGOR>(arg0, 6, b"IGOR", b"Igor Tiger", b"Pepe and Igor were close friends who always stuck together. However, when they embarked on their separate journeys to pursue their dreams, they had to part ways. Despite the distance, they promised to support each other and meet again in the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ppp_ecac858b1e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IGOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

