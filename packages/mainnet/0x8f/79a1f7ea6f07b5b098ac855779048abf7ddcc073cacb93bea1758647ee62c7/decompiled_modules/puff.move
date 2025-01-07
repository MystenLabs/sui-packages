module 0x8f79a1f7ea6f07b5b098ac855779048abf7ddcc073cacb93bea1758647ee62c7::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 6, b"PUFF", b"Puff the Puffin", b"The Best Meme Fair Launched on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AAA_9348_A_85_CC_4_B05_9808_28_CA_20_E6_CFEB_c0ea169f59_6237f8ac91.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

