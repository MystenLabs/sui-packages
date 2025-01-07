module 0x5d01706f438a4921f3afdee3c401d611c2cfbb3a27a7076f3a6a00cf2b58d4d::zoomer {
    struct ZOOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOOMER>(arg0, 6, b"ZOOMER", b"$ZOOMER", b"$ZOOMER CTO is led by a doxxed team and were here to stand on bidness ong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_55d808a342.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOOMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOOMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

