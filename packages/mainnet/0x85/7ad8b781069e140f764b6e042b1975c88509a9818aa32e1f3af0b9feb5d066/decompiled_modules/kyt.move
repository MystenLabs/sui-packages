module 0x857ad8b781069e140f764b6e042b1975c88509a9818aa32e1f3af0b9feb5d066::kyt {
    struct KYT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYT>(arg0, 9, b"KYT", b"Key token", b"Project of the people for the people by the people", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cbe4a26b-6d9f-4499-9738-d1b484cff557.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KYT>>(v1);
    }

    // decompiled from Move bytecode v6
}

