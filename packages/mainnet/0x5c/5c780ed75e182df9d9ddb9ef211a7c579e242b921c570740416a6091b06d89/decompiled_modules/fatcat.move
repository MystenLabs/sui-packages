module 0x5c5c780ed75e182df9d9ddb9ef211a7c579e242b921c570740416a6091b06d89::fatcat {
    struct FATCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATCAT>(arg0, 6, b"FatCat", b"Fat cat ON sui", b"xplore the power of a self-sustaining token economy with FATCAT. More than just a token, an exciting experiment in continuous growth and rewards, offering a uniquely enriching crypto experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fatcata_4faa4d47f2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

