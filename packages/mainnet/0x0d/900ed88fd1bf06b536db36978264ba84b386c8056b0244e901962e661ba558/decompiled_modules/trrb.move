module 0xd900ed88fd1bf06b536db36978264ba84b386c8056b0244e901962e661ba558::trrb {
    struct TRRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRRB>(arg0, 9, b"TRRB", b"the Terrib", x"49742063617074757265732074686520657373656e6365206f662065766572797468696e6720696e6372656469626c792074657272696679696e670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bb2a064a-9d0f-4906-92a0-fa6017445944.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

