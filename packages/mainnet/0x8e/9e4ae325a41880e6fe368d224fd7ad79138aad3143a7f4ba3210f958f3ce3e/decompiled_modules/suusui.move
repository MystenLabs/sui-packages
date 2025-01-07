module 0x8e9e4ae325a41880e6fe368d224fd7ad79138aad3143a7f4ba3210f958f3ce3e::suusui {
    struct SUUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUUSUI>(arg0, 6, b"SuuSui", b"SuuFlex meme", b"meme built on sui.1 million tokens will be distributed to supporters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dsadsa_1dddde5917.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

