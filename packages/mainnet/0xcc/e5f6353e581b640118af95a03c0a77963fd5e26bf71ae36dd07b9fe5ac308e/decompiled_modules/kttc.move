module 0xcce5f6353e581b640118af95a03c0a77963fd5e26bf71ae36dd07b9fe5ac308e::kttc {
    struct KTTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KTTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KTTC>(arg0, 9, b"KTTC", b"Kitty Cute", b"Kitty Cute will become source of Fund for stray cats.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e9c5eba-d868-45ea-a0c4-c69fc57614e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KTTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KTTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

