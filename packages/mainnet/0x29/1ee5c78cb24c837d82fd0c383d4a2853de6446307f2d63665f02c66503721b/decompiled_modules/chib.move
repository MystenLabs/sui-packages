module 0x291ee5c78cb24c837d82fd0c383d4a2853de6446307f2d63665f02c66503721b::chib {
    struct CHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIB>(arg0, 6, b"CHIB", b"ChibaSUI", b"Celebrating the origins of meme coins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/W_Ag_Ix_Tb_400x400_d71f051d71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

