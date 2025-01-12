module 0xdd4781c856518f2a205fe445d54a36a177219b388747bf266d915d48f3fe295f::eco {
    struct ECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECO>(arg0, 6, b"ECO", b"ECO AI", b"EcoAl: Al-driven agents ecosystem creating innovative utilities, generating revenue, and promoting sustainability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736679248221.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ECO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

