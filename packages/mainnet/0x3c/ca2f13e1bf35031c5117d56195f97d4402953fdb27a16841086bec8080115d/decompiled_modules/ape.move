module 0x3cca2f13e1bf35031c5117d56195f97d4402953fdb27a16841086bec8080115d::ape {
    struct APE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APE>(arg0, 9, b"APE", b" APE", b"APEAPE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe504998-5893-4944-bacd-f7c7bdd5a309.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APE>>(v1);
    }

    // decompiled from Move bytecode v6
}

