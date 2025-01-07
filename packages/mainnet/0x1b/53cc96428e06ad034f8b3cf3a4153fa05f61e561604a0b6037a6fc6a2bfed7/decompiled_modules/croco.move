module 0x1b53cc96428e06ad034f8b3cf3a4153fa05f61e561604a0b6037a6fc6a2bfed7::croco {
    struct CROCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCO>(arg0, 6, b"CROCO", b"CrocoSui", b"Whos ready to enjoy some green candles with $CROCO? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_Iz_Gip_W0_AA_7b5_R_0e357bf339.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

