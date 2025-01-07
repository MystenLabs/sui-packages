module 0xb4f9fd560fa7a07e2fd59771d81c479b7a4044674384498b09197ee3169b3705::purov {
    struct PUROV has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUROV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUROV>(arg0, 6, b"PUROV", b"Pavel Purov", b"THE FOUNDER OF TELEGRAM, CREATED THE PUROV TOKEN !!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pavel_b5e22bc55a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUROV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUROV>>(v1);
    }

    // decompiled from Move bytecode v6
}

