module 0x4e1466f59e9ec199453adc00371d036162bb8a1fa4765da7997924bd89e4d53::djt {
    struct DJT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJT>(arg0, 6, b"DJT", b"Doge J. Tramp", b"Don't miss out on the next big thing in crypto. Get your Doge J. Trump tokens today and be part of a community that's making wavesand memesacross the globe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027014_b86ea5fa33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJT>>(v1);
    }

    // decompiled from Move bytecode v6
}

