module 0x6c0c27a230752c30a5dca6548c088911a184c1bc34b9a6ef4755b46be1a37106::brokoli {
    struct BROKOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROKOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROKOLI>(arg0, 9, b"BROKOLI", b"Brokoli", b"Brokoli men", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/96f9ff2b-bbdb-411b-ac18-e646efd9ee64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROKOLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROKOLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

