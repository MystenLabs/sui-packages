module 0x9c6ba643f3c679bfce55998ca6a7c0940a594fd7dacbb19326f520093269f139::snut {
    struct SNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUT>(arg0, 9, b"SNUT", b"SNUT - Arc on Sui", x"5377696d6d696e6720746f75726e616d656e7420737461727473206f6e200a40376b5f66756e5f0a0a0a4e6f74206120636f70792c206a757374207468696e6b696e6720696e2073696d706c79206e65742c20697420697320776861742061206361746368696e6720766962652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/63c5787b9281c658faaf88622b9e0e9dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

