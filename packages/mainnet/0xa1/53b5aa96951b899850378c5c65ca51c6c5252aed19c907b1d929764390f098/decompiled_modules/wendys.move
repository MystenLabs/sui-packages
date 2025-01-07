module 0xa153b5aa96951b899850378c5c65ca51c6c5252aed19c907b1d929764390f098::wendys {
    struct WENDYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WENDYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WENDYS>(arg0, 6, b"WENDYS", b"SUIr this is a Wendy's", b"Excuse me SUIr, this is a wendy's", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_this_is_a_wendys_87ebb32468.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WENDYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WENDYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

