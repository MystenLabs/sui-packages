module 0x4574f23d84c31357448ba30ca1ad10b6387fe753fbe2f0ccb6ba280aea00b729::smario {
    struct SMARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMARIO>(arg0, 6, b"SMARIO", b"Suiper Mario", x"535549504552204d4152494f206f6e205355492069732061206d656d6520696e73706972656420627920746865205355504552204d4152494f2042524f53532067616d652c206974207265666c65637473206f7074696d69736d2c20737472656e67746820616e64206368617269736d612c2065766572797468696e67206120676f6f6420436fc3ad6e206d656d65206e656564732e2e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734392301824.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMARIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMARIO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

