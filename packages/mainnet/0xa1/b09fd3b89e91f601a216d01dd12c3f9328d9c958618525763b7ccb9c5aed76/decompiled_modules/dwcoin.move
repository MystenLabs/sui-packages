module 0xa1b09fd3b89e91f601a216d01dd12c3f9328d9c958618525763b7ccb9c5aed76::dwcoin {
    struct DWCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWCOIN>(arg0, 9, b"DWCOIN", b"Darwin", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60a92d34-1606-4d64-bfd5-8caf81142d64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DWCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

