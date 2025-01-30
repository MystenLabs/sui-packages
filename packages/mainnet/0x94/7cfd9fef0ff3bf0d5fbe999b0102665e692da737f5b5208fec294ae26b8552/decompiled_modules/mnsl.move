module 0x947cfd9fef0ff3bf0d5fbe999b0102665e692da737f5b5208fec294ae26b8552::mnsl {
    struct MNSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNSL>(arg0, 9, b"MNSL", b"MonSoli", b"big lufe is big love enjoy from everything ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a113508a-d004-49a7-8e4a-e6af17f34aef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

