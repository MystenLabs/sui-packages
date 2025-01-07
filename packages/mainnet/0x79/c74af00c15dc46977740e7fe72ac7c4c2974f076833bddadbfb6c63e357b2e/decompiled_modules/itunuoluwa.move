module 0x79c74af00c15dc46977740e7fe72ac7c4c2974f076833bddadbfb6c63e357b2e::itunuoluwa {
    struct ITUNUOLUWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITUNUOLUWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITUNUOLUWA>(arg0, 9, b"ITUNUOLUWA", b"Akin", b"Akin is a boy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4b58371-21d5-4d80-93fe-0b50b58ec002.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITUNUOLUWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ITUNUOLUWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

