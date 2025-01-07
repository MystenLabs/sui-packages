module 0xc7277fff919128afb443830416e0de286b93ec26eb5291fc74a30173e867a4af::aaadodo {
    struct AAADODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADODO>(arg0, 6, b"AAADODO", b"aaaDODO", x"24616161444f444f205468696e6b696e672069732077686174206d616b6573207573207269636820696e207468652067616d652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_01_47_25_227f0c27a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADODO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

