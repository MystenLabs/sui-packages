module 0xb6860ac75a8c186b6b9e70dfd65cc274f8129d32665abc8bbe0c356ea46405de::hnk {
    struct HNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNK>(arg0, 9, b"HNK", b"Heniken", b"Heniken bear", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0764e35-aa67-4e50-a968-7a47b781bad1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

