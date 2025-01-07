module 0x69fbe92c887a1c77937750c77259cbfac0416f381ed64a73d7a93b151d8db8a7::ac {
    struct AC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AC>(arg0, 6, b"AC", b"aaaa crabs", b"Surrounded by sea, Iceland is rich in fisheries. The country relies on the fishing industry to make a living, and even the coins are engraved with a variety of sea creatures to pay tribute to them", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/276_d4888e3bad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AC>>(v1);
    }

    // decompiled from Move bytecode v6
}

