module 0xf584b33c57a2cf15aff071a3f189ab219ef17aaf10171172c484cdaba3b88b53::spug {
    struct SPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUG>(arg0, 6, b"SPUG", b"SuiPug", b"Boosting #Sui Network power with #SuiPug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9510_2197c9251a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

