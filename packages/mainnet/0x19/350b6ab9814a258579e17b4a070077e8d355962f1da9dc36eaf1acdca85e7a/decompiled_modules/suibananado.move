module 0x19350b6ab9814a258579e17b4a070077e8d355962f1da9dc36eaf1acdca85e7a::suibananado {
    struct SUIBANANADO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBANANADO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBANANADO>(arg0, 6, b"SuiBananado", b"Sui Bananado", x"43544f206d656d636f696e200a6c6574277320676f206d616b6520736f6d657468696d6720424947204c4647", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_2_5424eac582.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBANANADO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBANANADO>>(v1);
    }

    // decompiled from Move bytecode v6
}

