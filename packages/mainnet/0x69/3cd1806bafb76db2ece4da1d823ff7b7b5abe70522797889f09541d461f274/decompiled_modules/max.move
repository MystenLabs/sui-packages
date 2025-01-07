module 0x693cd1806bafb76db2ece4da1d823ff7b7b5abe70522797889f09541d461f274::max {
    struct MAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAX>(arg0, 6, b"Max", b"Max the Dog", b"Wooof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pepe_max_head_e0a0d800a3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

