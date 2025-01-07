module 0xb3a033feb2d778b15912ef10167c5233ea9da0901929fddfbc9b009465bee96f::blud {
    struct BLUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUD>(arg0, 6, b"BLUD", b"BLUD SUI", x"426c7564207468696e6b732068657320676f696e6720746f20612062696c6c696f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/p98m_Xon_400x400_17c281e0a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

