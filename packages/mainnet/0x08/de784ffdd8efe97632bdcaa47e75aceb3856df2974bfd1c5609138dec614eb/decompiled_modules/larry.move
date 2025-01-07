module 0x8de784ffdd8efe97632bdcaa47e75aceb3856df2974bfd1c5609138dec614eb::larry {
    struct LARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LARRY>(arg0, 6, b"LARRY", b"Larry The Bird", b"Once upon a time the twitter logo was a bird. That bird had a name. $LARRY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/portal_7dcbc4f42f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LARRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LARRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

