module 0x4ab7077e4c926eb4948a9538d54a9f2b23b8f063f84485bf440709e66d4ecbc9::dank {
    struct DANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANK>(arg0, 6, b"DANK", b"SUIDANK", b"Dank on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5507_20e65f2408.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

