module 0x12ed9f858fdecdd7d65a3073b287b45e6bbad91bf7b9c9373f72a08f4b671de2::fuck {
    struct FUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCK>(arg0, 6, b"FUCK", b"rsdtfghj", b"3a5465er6t7g", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d7e693fa7a880603e39b3ef7a35c6ed3_1_545e4ade32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

