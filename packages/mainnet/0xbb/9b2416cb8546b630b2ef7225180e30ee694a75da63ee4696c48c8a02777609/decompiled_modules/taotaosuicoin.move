module 0xbb9b2416cb8546b630b2ef7225180e30ee694a75da63ee4696c48c8a02777609::taotaosuicoin {
    struct TAOTAOSUICOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAOTAOSUICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAOTAOSUICOIN>(arg0, 6, b"TAOTAOSUICOIN", b"TAOTAO", b"Smiling Dolphin Name is $TAOTAO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/udxvy_Wzh_400x400_b6c6a6fe54.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAOTAOSUICOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAOTAOSUICOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

