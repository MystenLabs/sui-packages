module 0xac60ed931ddc6a61b355998bd7efd8efb1ed87d7fe9a5440d9a987bf25bda1d6::meix {
    struct MEIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEIX>(arg0, 9, b"MEIX", b"Hinme", b"Of clan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d76f62e7-0772-485c-9c7f-36b8375830d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

