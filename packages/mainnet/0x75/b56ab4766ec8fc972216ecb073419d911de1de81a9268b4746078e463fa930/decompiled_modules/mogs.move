module 0x75b56ab4766ec8fc972216ecb073419d911de1de81a9268b4746078e463fa930::mogs {
    struct MOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOGS>(arg0, 6, b"MOGS", b"MOG SUI", b"MOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e53c62a9bc94d8c4acc232be83ef02bc_54c03816b4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

