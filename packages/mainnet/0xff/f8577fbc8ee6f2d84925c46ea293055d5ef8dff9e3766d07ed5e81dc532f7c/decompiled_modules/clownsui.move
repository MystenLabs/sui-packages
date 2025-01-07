module 0xfff8577fbc8ee6f2d84925c46ea293055d5ef8dff9e3766d07ed5e81dc532f7c::clownsui {
    struct CLOWNSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOWNSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOWNSUI>(arg0, 6, b"CLOWNSUI", b"CLOWN ON SUI", b"Need community solig. And we Will bonded together ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004628_0679408537.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOWNSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOWNSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

