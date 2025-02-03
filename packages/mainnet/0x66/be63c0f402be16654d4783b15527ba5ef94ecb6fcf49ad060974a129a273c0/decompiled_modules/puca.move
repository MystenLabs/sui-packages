module 0x66be63c0f402be16654d4783b15527ba5ef94ecb6fcf49ad060974a129a273c0::puca {
    struct PUCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUCA>(arg0, 6, b"PUCA", b"Purple Cat", x"48692c206d79206e616d6527732050554341202049276d20612063617420616e642049276d20707572706c652c2070757272205e5f5e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001326_ef055d3316.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

