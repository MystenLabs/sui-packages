module 0x7f176e40cba740215c7374917c30b23bdebcb44857c670eaad577d7030ec91d6::twonks {
    struct TWONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWONKS>(arg0, 6, b"TWONKS", b"Twonks sui", b"Twonks is a community-driven meme token inspired by the hilariously absurd world of Twonks Comics by Steve Nelson. With its roots in satire and mischief, Twonks aims to become the most outrageously entertaining memecoin in existence, celebrating the co", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048490_f4ef36593c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWONKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWONKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

