module 0x722632e68cc36b6fcef101b260d19cc8d22a008b3ea84fa2338300ec9636f03f::hoopo {
    struct HOOPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOOPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOOPO>(arg0, 6, b"HOOPO", b"Hoopo", b"The memecoin with a heart of gold (and a pouch full of crypto)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000023854_85f4d250f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOOPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOOPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

