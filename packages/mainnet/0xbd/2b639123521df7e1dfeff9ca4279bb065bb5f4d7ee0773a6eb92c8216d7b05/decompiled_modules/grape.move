module 0xbd2b639123521df7e1dfeff9ca4279bb065bb5f4d7ee0773a6eb92c8216d7b05::grape {
    struct GRAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAPE>(arg0, 6, b"GRAPE", b"grape", x"54686520686f6d65206f6620477261706520616e642024475241504520436f696e2e204261636b6564206279200a40616e696d6f63616272616e6473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000346_f11c1bbb1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

