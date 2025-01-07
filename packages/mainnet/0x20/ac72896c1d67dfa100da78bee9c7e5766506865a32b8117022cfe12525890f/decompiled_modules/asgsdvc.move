module 0x20ac72896c1d67dfa100da78bee9c7e5766506865a32b8117022cfe12525890f::asgsdvc {
    struct ASGSDVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASGSDVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASGSDVC>(arg0, 9, b"ASGSDVC", b"ASDAS", b"VBNVB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c39c0304-1a46-4c5a-9c58-7d3555ec352e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASGSDVC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASGSDVC>>(v1);
    }

    // decompiled from Move bytecode v6
}

