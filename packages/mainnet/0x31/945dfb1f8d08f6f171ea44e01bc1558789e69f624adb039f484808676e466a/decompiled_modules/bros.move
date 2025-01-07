module 0x31945dfb1f8d08f6f171ea44e01bc1558789e69f624adb039f484808676e466a::bros {
    struct BROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROS>(arg0, 6, b"Bros", b"bros", b"Hi bro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000441_59d0d98697.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

