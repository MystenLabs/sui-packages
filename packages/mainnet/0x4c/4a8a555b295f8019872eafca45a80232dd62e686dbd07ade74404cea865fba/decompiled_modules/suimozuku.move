module 0x4c4a8a555b295f8019872eafca45a80232dd62e686dbd07ade74404cea865fba::suimozuku {
    struct SUIMOZUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOZUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOZUKU>(arg0, 6, b"SuiMOZUKU", b"MOZUKU", b"$MOZUKU as we found out, is the birth given name of the world famous dog Kabosu that inspired the DOGE meme! We want immortalize his memory in this token and invite you to join us! On this page you can find all the proof and project info you need! Welcome!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_fddc09f2dd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOZUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOZUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

