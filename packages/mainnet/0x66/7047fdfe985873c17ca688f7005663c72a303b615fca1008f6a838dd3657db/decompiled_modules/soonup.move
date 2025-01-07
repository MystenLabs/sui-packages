module 0x667047fdfe985873c17ca688f7005663c72a303b615fca1008f6a838dd3657db::soonup {
    struct SOONUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOONUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOONUP>(arg0, 6, b"Soonup", b"upup", b"up up =1$", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_1f2aeb093c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOONUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOONUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

