module 0x571b537313abc4d66d68a86d422cd7c7020b91fb73aa3c1069923e3acdd7307d::bluec {
    struct BLUEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEC>(arg0, 6, b"BLUEC", b"Blue Eyed Cat", b"A blue-eyed cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6btmucumawy31_3b54179087.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEC>>(v1);
    }

    // decompiled from Move bytecode v6
}

