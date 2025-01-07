module 0x8c98ad8318e288ad9df01ac3bef131df51c9e518eb0f884afac022bde83e19c3::gecko {
    struct GECKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GECKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GECKO>(arg0, 6, b"GECKO", b"Gecko On Sui", b"Gecko is known for their sticky feet and big eyes, geckos could symbolize adaptability and fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gecko_c4ccff00dd.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GECKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GECKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

