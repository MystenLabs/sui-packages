module 0x28b58b8c693fd168162b824a0eece26599a98d85e3d08fc6093a0239ad01e9d1::xx {
    struct XX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XX>(arg0, 6, b"XX", b"XToken", b"X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732172787443.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

