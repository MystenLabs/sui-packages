module 0x544fac82c4901ab909fa64bea5ac597a8ca55c87693eaf321a7df783e72cb64e::chiikawa {
    struct CHIIKAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIIKAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIIKAWA>(arg0, 6, b"Chiikawa", b"First Chiikawa Sui", b"First Chiikawa on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_2_8_49adbf5731.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIIKAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIIKAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

