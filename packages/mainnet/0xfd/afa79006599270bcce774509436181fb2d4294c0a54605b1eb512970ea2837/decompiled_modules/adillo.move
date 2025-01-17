module 0xfdafa79006599270bcce774509436181fb2d4294c0a54605b1eb512970ea2837::adillo {
    struct ADILLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADILLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADILLO>(arg0, 6, b"ADILLO", b"Adillo", b"Void panda is for those wo believe wealth comes to those who chill,. Whatever, win anyway - because sometimes the void gives back.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026434_8db2e4e5f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADILLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADILLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

