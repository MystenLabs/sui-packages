module 0xf3f9ab64e212f28f904faa7055504ccbe2f9d4acb26a63c18c5992fe136101f9::younes {
    struct YOUNES has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOUNES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOUNES>(arg0, 6, b"YOUNES", b"YOUNES SUI", b"Embrace your inner chaos and absurdity. There are no limits, no social anxiety, no psyop keeping you down. Just You vs You.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/thunder_a594ccd530.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOUNES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOUNES>>(v1);
    }

    // decompiled from Move bytecode v6
}

