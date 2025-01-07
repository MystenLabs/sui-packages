module 0x3e236d92b669770f93795216ffc4ae44fccd6519b10890509d85df18f720f827::agx {
    struct AGX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGX>(arg0, 9, b"AGX", b"Agapeonx", b"community driven ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d39e139-705c-4ac7-a5c2-9b19ec9eb039.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGX>>(v1);
    }

    // decompiled from Move bytecode v6
}

