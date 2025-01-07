module 0x9c2252506a6dc5f55454bb1e9e9a71c3589503fe556c8131bc7cfe4e2e8fdf63::zangg {
    struct ZANGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZANGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZANGG>(arg0, 9, b"ZANGG", b"Zang", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bedf60c7-b60b-4e06-a89b-fc36a1843f67.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZANGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZANGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

