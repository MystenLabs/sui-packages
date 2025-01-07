module 0x28a99695239dad9458231d9247d20927a3c1170ed2b46dbea5f9ac544f4fda41::snut {
    struct SNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUT>(arg0, 9, b"SNUT", b"SNUT - Arc on Sui", x"4e6f74206120636f70792c206a757374207468696e6b696e6720696e2073696d706c79206e65742c20697420697320776861742061206361746368696e6720766962652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cf9c68758de638dcd81dd6bae48fb856blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

