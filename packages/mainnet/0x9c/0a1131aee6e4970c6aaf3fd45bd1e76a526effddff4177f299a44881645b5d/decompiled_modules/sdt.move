module 0x9c0a1131aee6e4970c6aaf3fd45bd1e76a526effddff4177f299a44881645b5d::sdt {
    struct SDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDT>(arg0, 6, b"SDT", b"SuiDuckz Token", b"A community token for all SuiDuckz believers. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020657_f2c837c288.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

