module 0x52cd4a968dcdff9cbbb87559877492ba3267723b7df1d8ea3a0fb6ceac90292e::gupp {
    struct GUPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUPP>(arg0, 6, b"GUPP", b"Guppy fish", b"Cutest Fish on aquarium and ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gill_1bf31c5806.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

