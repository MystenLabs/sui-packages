module 0x8deae06e28ac5274f8a16aa63b148af66878b52d24e3761c4f9cd7507166b459::dank {
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

