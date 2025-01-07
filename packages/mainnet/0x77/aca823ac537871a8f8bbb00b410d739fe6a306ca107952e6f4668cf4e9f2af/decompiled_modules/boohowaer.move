module 0x77aca823ac537871a8f8bbb00b410d739fe6a306ca107952e6f4668cf4e9f2af::boohowaer {
    struct BOOHOWAER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOHOWAER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOHOWAER>(arg0, 6, b"BOOHOWAER", b"bo'oh'o'wa'er", b"Say 'ello to BO'OH'O'WA'ER, the poshest coin on Sui! Grab yourself a nice bo'oh o' wa'er, mate, 'cause this one's gonna be splashin' through the markets like tea at high noon. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_71cbcd9dd8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOHOWAER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOHOWAER>>(v1);
    }

    // decompiled from Move bytecode v6
}

