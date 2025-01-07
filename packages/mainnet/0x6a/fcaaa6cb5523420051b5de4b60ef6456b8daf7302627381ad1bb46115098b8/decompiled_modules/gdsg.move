module 0x6afcaaa6cb5523420051b5de4b60ef6456b8daf7302627381ad1bb46115098b8::gdsg {
    struct GDSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDSG>(arg0, 9, b"GDSG", b"SDGDSA", b"GVSSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa1cfab7-a347-45f1-a6d9-da24eb75f29e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

