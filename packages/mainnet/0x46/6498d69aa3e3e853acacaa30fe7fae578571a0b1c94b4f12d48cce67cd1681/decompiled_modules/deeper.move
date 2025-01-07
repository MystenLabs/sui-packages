module 0x466498d69aa3e3e853acacaa30fe7fae578571a0b1c94b4f12d48cce67cd1681::deeper {
    struct DEEPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPER>(arg0, 6, b"DEEPER", b"DeeperBook Token", b"DeepBook Token Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_79ad8a8f03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

