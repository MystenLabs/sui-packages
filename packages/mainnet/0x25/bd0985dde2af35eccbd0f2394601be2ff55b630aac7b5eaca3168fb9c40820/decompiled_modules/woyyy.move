module 0x25bd0985dde2af35eccbd0f2394601be2ff55b630aac7b5eaca3168fb9c40820::woyyy {
    struct WOYYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOYYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOYYY>(arg0, 9, b"WOYYY", b"WOYYY!!!", b"Woy token is an expression of emotion towards a situation that has occurred", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a98284a1-7966-4356-ae88-f7d6eb57717f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOYYY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOYYY>>(v1);
    }

    // decompiled from Move bytecode v6
}

