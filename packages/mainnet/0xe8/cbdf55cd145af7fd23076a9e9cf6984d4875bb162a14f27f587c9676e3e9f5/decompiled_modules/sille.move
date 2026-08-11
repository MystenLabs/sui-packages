module 0xe8cbdf55cd145af7fd23076a9e9cf6984d4875bb162a14f27f587c9676e3e9f5::sille {
    struct SILLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILLE>(arg0, 6, b"Sille", x"53696c6cc3a920536e61636b73", x"57686174e2809973206576656e206d6f72652053696c6c65207468616e20736e61636b696e67206f6e2074686573652074656e646965732e20566572792077656c6c20636f756c6420706f737369626c7920626520e2809c53696c6cc3a9e2809d20636f6d696e6720746f206c6966652e20596f75e280997665206265656e207761726e656420f09f8c95", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1786426452836.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SILLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

