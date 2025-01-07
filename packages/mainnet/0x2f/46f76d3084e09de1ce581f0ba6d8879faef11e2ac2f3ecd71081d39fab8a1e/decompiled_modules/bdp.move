module 0x2f46f76d3084e09de1ce581f0ba6d8879faef11e2ac2f3ecd71081d39fab8a1e::bdp {
    struct BDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDP>(arg0, 9, b"BDP", b"Boredape", b"Bring the NFT niche to Sui ecosystem ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/261f16af-bf04-404d-a558-635828f17f5c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDP>>(v1);
    }

    // decompiled from Move bytecode v6
}

