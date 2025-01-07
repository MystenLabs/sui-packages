module 0x12f2861cd7d4e7bdec49a715aa4ee4c7830f72a1d6e52e18d17163bd1feba22e::suiquant {
    struct SUIQUANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIQUANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIQUANT>(arg0, 6, b"SUIQUANT", b"QUANT", b"Quant is anime character influencer. This is my quant", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3560_fd9aaa1fe8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIQUANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIQUANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

