module 0x596b08960068038c480d2ba80a8b30d71e7e7f2867f60600bac67d841ae2cfef::pepewise {
    struct PEPEWISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEWISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEWISE>(arg0, 6, b"PEPEWISE", b"PepeWise", b"Pepewise is a sinister hybrid of the iconic clown Pennywise and the legendary meme frog Pepe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b35e21d0_f309_4e8e_87d9_420ab98a9156_15f056d855.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEWISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEWISE>>(v1);
    }

    // decompiled from Move bytecode v6
}

