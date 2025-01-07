module 0x286a8053d5decd04d44bd8ab089bdf234fa189c96b1bf0b9d87c357f2e4b2bba::suibrain {
    struct SUIBRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBRAIN>(arg0, 6, b"SUIBRAIN", b"CENTRAL BRAIN of SUI", b"$SUIBRAIN is the powerhouse token driving the intelligence of Sui. As the core of innovation, it harnesses the collective knowledge and creativity of the community. Join $SUIBRAIN and be part of the brainy revolution shaping the future of Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIBRAIN_22919eca61.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBRAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBRAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

