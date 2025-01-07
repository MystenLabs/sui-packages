module 0xb287903dd5c8d1c0a722d4a605a4e65f567b8a65b825bbb169a52ffa4f345c61::efnc {
    struct EFNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EFNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EFNC>(arg0, 6, b"EFNC", b"Efficiency", b"Efficiency is a meme coin symbolizing Department of Governmental Efficiency and it's effort to Make America Great Again. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gemini_Generated_Image_j2cgjuj2cgjuj2cg_9d8cce414f.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EFNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EFNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

