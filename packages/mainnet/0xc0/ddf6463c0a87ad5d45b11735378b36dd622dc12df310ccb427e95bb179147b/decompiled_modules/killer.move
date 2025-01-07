module 0xc0ddf6463c0a87ad5d45b11735378b36dd622dc12df310ccb427e95bb179147b::killer {
    struct KILLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILLER>(arg0, 6, b"KILLER", b"ORCAT", b" First ever cat whale spotted on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/orca_7cd25b49b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KILLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

