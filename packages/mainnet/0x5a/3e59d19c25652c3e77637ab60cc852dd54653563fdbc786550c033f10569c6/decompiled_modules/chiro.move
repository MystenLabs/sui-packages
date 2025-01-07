module 0x5a3e59d19c25652c3e77637ab60cc852dd54653563fdbc786550c033f10569c6::chiro {
    struct CHIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIRO>(arg0, 6, b"CHIRO", b"ChiroOnSui", b"CHIRO - the cutest but most vicious crocodile on the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001287_34c58a028b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

