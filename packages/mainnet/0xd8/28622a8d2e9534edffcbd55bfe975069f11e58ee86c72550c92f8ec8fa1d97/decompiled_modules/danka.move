module 0xd828622a8d2e9534edffcbd55bfe975069f11e58ee86c72550c92f8ec8fa1d97::danka {
    struct DANKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANKA>(arg0, 6, b"DANKA", b"SUIDANK", b"Dank on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5507_20e65f2408.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

