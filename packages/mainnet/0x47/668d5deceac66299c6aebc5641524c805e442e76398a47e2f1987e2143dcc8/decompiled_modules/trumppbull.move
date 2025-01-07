module 0x47668d5deceac66299c6aebc5641524c805e442e76398a47e2f1987e2143dcc8::trumppbull {
    struct TRUMPPBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPPBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPPBULL>(arg0, 9, b"TRUMPPBULL", b"TrUmpp", b"Trumpbulllllll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/72195a85-4eb1-4de7-b397-932d7b1ec3f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPPBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPPBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

