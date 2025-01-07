module 0x176bbce9cfaa3fd817ab434bc89103d978d1a869a552f4a8b178be90dacfa0c3::malakai {
    struct MALAKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MALAKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MALAKAI>(arg0, 6, b"MALAKAI", b"Malakai Sui", b"Most photogenic 7 week old", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_27_18_17_46_7877767f2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MALAKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MALAKAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

