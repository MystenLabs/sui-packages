module 0xc1c24f776a453237ef8ba42fe231bfb4506bc6f50e68d4f162672c5a0ab6d347::tys6u {
    struct TYS6U has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYS6U, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYS6U>(arg0, 9, b"TYS6U", b"tyuek", b"HFDGASU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/53aba0a5be0753b49a1a104ff50a068bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TYS6U>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYS6U>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

