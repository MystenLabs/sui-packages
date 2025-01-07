module 0xd347f6853d1638dc3c960999b9cf142e847a9ccf7607c4326a0dfe72e84e29ef::evan {
    struct EVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVAN>(arg0, 6, b"EVAN", b"EvanOnSui", b"$EVAN, inspiretd by Evan Cheng - the founder of SUI Blockcheen - the memecoin for the autisstic and retardzz nerdz that make SUI great.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000164_d60e16d727.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

