module 0x25a67f976e0c39b11eda9a81476ceb3e4b19e8c10c69146ab3351ee63083b6c::snut {
    struct SNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUT>(arg0, 9, b"SNUT", b"$SNUT - Arc on Sui", x"5377696d6d696e6720746f75726e616d656e7420737461727473206f6e200a40376b5f66756e5f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bffffdc95a786d634df995bb5dd58850blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

