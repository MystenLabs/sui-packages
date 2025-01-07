module 0x4b6f9d1fa3f18f765c4bde27ad159a1a8ec5a71ab464c0f5b6edc82cb1ce52dd::chop {
    struct CHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOP>(arg0, 6, b"CHOP", b"Chop SUI", b"Chop suey is a dish from American Chinese cuisine and other forms of overseas Chinese cuisine, generally consisting of meat and eggs, cooked quickly with vegetables such as bean sprouts, cabbage, and celery, and bound in a starch-thickened sauce.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chopseuy_20b71731f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

