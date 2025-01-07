module 0xe8a4a8b911255a6492b41ad632695dcd9bdc9f4e17c6d1c3ff068e3968102a2e::suwu {
    struct SUWU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUWU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUWU>(arg0, 6, b"SUWU", b"Suinicorn - Memojies coming to Sui", x"497420697320696e20746865206e616d65210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suinivorn_caf57166a1.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUWU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUWU>>(v1);
    }

    // decompiled from Move bytecode v6
}

