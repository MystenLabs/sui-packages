module 0x73cc6eb6775467c9d0d6817ab00818753c02aec32076f118d35190438a5b67e3::sugarbean {
    struct SUGARBEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGARBEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGARBEAN>(arg0, 6, b"SugarBean", b"Sugar Bean", b"Let's jump together, Jelly Bean Boy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012743_af76e82643.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGARBEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGARBEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

