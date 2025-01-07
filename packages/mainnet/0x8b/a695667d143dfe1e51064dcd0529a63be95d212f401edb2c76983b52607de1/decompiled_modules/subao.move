module 0x8ba695667d143dfe1e51064dcd0529a63be95d212f401edb2c76983b52607de1::subao {
    struct SUBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBAO>(arg0, 6, b"SUBAO", b"suibao", b"The dev are gone, but we will complete the mission of sending the $SUBAO Project to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_03_01_37_03_c399fcb63e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUBAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

