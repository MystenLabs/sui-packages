module 0x2d37073f69fd629f60615b6d9ad63ffc878e9918f981d1154305162cf82109b::dogp {
    struct DOGP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGP>(arg0, 6, b"DOGP", b"Dogphin", b"Dogphin is Sui's favorite pet. He surfs the waves of the chart with the intelligence of a dolphin and will always stay with his community like a faithful dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000064004_c84d0ccd16.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGP>>(v1);
    }

    // decompiled from Move bytecode v6
}

