module 0xb873611fdd909e7a7b03952cfab69f23dc8ad054e91b7db6286383584db97501::vnka {
    struct VNKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VNKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VNKA>(arg0, 6, b"Vnka", b"Suivanka", x"53756976616e6b61206472696e6b732077617465722e0a53756976616e6b6120666c69707320536f6c616e612e0a526561647920666f722061206d6567612053756976616e6b61203f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002775_18f1471b47.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VNKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VNKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

