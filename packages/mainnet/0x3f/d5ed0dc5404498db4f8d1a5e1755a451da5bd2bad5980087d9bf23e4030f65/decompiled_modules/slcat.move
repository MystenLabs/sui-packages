module 0x3fd5ed0dc5404498db4f8d1a5e1755a451da5bd2bad5980087d9bf23e4030f65::slcat {
    struct SLCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLCAT>(arg0, 9, b"SLCAT", b"LuckyCat", x"302e3030303030332070657263656e74206c75636b20626f6f73742070657220746f6b656e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b9f76db-63a7-46e4-aa2a-aab5953617e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

