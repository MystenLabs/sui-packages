module 0x7037b8aa002d52777f622ffbc56467e1099b47e35543e27577ff5745ec8950af::donk {
    struct DONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONK>(arg0, 6, b"DONK", b"Donk On Sui", b" MEET $DONK Yeehaw! $DONK is ready to kick some asses! Move over dogs, frogs, and cats  its time for the donkey takeover! $DONK is here to bring the meme game to a whole new level.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_19_28_35_1f80374b78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

