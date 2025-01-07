module 0x3c863459ab1291e6ff9dfc35925c631965fdd42268c2c230a2b6d7beea0ab706::h33 {
    struct H33 has drop {
        dummy_field: bool,
    }

    fun init(arg0: H33, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H33>(arg0, 6, b"H33", b"Hopdog", b"d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Illustration46sdfhj_2c6927b992.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H33>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<H33>>(v1);
    }

    // decompiled from Move bytecode v6
}

