module 0xdeb4a72d5be5bcbb9b76ce86686189df54fd966af3e82354a41c4ece7905559d::duckaui {
    struct DUCKAUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKAUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKAUI>(arg0, 6, b"Duckaui", b"Duck sui", b"Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000904596_bb0a5d4990.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKAUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKAUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

