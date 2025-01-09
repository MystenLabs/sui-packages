module 0x3cf6bcc1df6861564db5480abb53144d060e09043f214b2617fb70c13f3df8c0::bond {
    struct BOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOND>(arg0, 6, b"BOND", b"LAFD Rescue Dog", b"He is LAFD Rescue Dog.His name is BOND.His mission is saving us and BOND!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736453252918.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

