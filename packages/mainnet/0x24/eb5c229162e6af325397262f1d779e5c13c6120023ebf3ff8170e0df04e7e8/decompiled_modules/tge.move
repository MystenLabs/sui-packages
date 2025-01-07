module 0x24eb5c229162e6af325397262f1d779e5c13c6120023ebf3ff8170e0df04e7e8::tge {
    struct TGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGE>(arg0, 9, b"TGE", b"Tokenhehe", b"TGEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78be95cf-a542-472c-9c35-2dd67636880d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

