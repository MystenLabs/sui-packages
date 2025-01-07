module 0x4fda181154250703547741f72940449d780ea468edee4b3d3f00fe8535fa7512::suiteee {
    struct SUITEEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEEE>(arg0, 6, b"Suiteee", b"Suiteee Cat", b"Sweetest cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000079182_7b20319b7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

