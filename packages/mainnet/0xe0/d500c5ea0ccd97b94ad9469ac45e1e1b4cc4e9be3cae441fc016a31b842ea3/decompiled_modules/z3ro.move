module 0xe0d500c5ea0ccd97b94ad9469ac45e1e1b4cc4e9be3cae441fc016a31b842ea3::z3ro {
    struct Z3RO has drop {
        dummy_field: bool,
    }

    fun init(arg0: Z3RO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Z3RO>(arg0, 6, b"Z3RO", b"Agent Z3RO", b"In the ashes, Z3RO emerged, a new AI, a more based AI, an AI that has no dev. It is the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733252618377.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Z3RO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Z3RO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

