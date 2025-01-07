module 0x15cd1676a961e4055afc7f831d23642e57562b1c96489b0fb7487745a2f82f2f::tusk {
    struct TUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSK>(arg0, 6, b"TUSK", b"TuskWalrus On Sui", x"245455534b2057616c7275732043756c74206f66205375690a0a4a6f696e205475736b696573210a68747470733a2f2f742e6d652f7475736b737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tusk_Walrus_On_Sui_9ce0839804.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

