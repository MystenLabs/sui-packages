module 0x51d793cbf11a5a765b0d83344e8edd194504072c7a14dd014e8b2720bd855863::kishita {
    struct KISHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KISHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KISHITA>(arg0, 6, b"KISHITA", b"Kishita", b"Kishita, the adorable girlfriend of the famous meme dog sensation , Kishu Inu!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1726318466072_e85a5146bd13dc413083d4a7711e895b_0c9c921d95.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KISHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KISHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

