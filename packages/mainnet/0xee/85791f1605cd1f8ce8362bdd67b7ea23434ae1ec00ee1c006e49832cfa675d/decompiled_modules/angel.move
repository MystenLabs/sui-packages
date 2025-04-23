module 0xee85791f1605cd1f8ce8362bdd67b7ea23434ae1ec00ee1c006e49832cfa675d::angel {
    struct ANGEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGEL>(arg0, 6, b"Angel", b"Angelcoin", b"Angel coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1207_c8152d7dc7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

