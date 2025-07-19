module 0xaab7029a11de1590bf62eb42a96b5d3c7a66f5ffc02b5625d5e2915ffc58994d::jam {
    struct JAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAM>(arg0, 6, b"JAM", b"Sui jam", b"Just A Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Jam_1_7a164cc2dc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

