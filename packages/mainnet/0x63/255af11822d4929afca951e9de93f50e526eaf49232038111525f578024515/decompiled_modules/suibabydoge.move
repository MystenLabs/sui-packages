module 0x63255af11822d4929afca951e9de93f50e526eaf49232038111525f578024515::suibabydoge {
    struct SUIBABYDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBABYDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBABYDOGE>(arg0, 9, b"BabyDoge", b"SuiBabyDoge", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBABYDOGE>(&mut v2, 1000000000000000000, @0x6937dc4c4870ffb539d099691023a77288be6db6f566ce3f046c389dd5c7fab6, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBABYDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBABYDOGE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

