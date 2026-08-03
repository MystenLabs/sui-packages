module 0xa91457326a2f9cc4af0ab5b842c414726562d11a6192c9461b2945379ce8b6c8::auto {
    struct AUTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUTO>(arg0, 6, b"AUTO", b"evucexvec", b"exchange stock timelines loading stock exchange", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1785735540100.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

