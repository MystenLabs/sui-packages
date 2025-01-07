module 0x28b99bb51655ce00f8221773ffcfe8584f2e7c31f05c1f6c57d658e33a515d98::pip {
    struct PIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIP>(arg0, 9, b"PIP", b"Gggx", b"Best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67e460ee-18c4-4ccd-afe4-fa0b704b0706.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

