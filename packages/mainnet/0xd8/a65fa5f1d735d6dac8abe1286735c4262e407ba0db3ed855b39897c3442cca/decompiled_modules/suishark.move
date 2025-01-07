module 0xd8a65fa5f1d735d6dac8abe1286735c4262e407ba0db3ed855b39897c3442cca::suishark {
    struct SUISHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHARK>(arg0, 6, b"SuiShark", b"Sui Shark", b"This is Shark but on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suishark_045274eec7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

