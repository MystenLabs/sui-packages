module 0x5d8c32597167a7b02b3ee4542a6d19a3c7a68a74b10b45a0cda642799c02407b::grhr {
    struct GRHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRHR>(arg0, 9, b"GRHR", b"GRAY HERO", b"Your Fave Token!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d18855f7-f269-4e81-a710-a1d3a6e00d3b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

