module 0x162b825959eb173c38e230fbc4c50404122574d2835946f03cc6c42313b6b092::timmy {
    struct TIMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMMY>(arg0, 6, b"TIMMY", b"Timmy The Beluga", b"Timmy is here to make waves, offering a vibrant ecosystem for supporters and believers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_26_808681a3d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

