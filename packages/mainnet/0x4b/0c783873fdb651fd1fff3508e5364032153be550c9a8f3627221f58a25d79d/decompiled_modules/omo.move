module 0x4b0c783873fdb651fd1fff3508e5364032153be550c9a8f3627221f58a25d79d::omo {
    struct OMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMO>(arg0, 6, b"OMO", b"omo", b"DAO COMMUNITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/artifact_2f2f5a25dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

