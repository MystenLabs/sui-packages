module 0x1756f7b7deeede5c00f287a8a842319a12d7a840bbe1521c0407def1e7561933::harper {
    struct HARPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARPER>(arg0, 6, b"HARPER", b"HARPER ON SUI", b"Lets go harper", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030075_57f103661e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

