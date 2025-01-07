module 0x174e35d019e962038407f3de46217c4c696e2724f4ffeea7c646329213a940c5::rosuii {
    struct ROSUII has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSUII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSUII>(arg0, 6, b"roSUII", b"roSUI", b"Rose on sui , roSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rose_a8d9379fe7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSUII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSUII>>(v1);
    }

    // decompiled from Move bytecode v6
}

