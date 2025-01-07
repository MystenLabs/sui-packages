module 0x3d6ba035319b93f70cd0a4ca79f0c249c6e82371c4c92efbe6097df57dd16436::bberry {
    struct BBERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBERRY>(arg0, 6, b"BBerry", b"BlueBerry", b"Everyones favorite cute Berry on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7360_61055099b1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

