module 0xc17a585dd5a261e682a616a361dc05023e040ea0033f576a08c72a53c4e3e8c6::tea {
    struct TEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEA>(arg0, 6, b"TEA", b"Spirit Tea", b"Making someting for nothing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053374_9ee8742166.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

