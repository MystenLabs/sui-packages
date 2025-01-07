module 0xc0ed07a398e86ad57474b11ad41b91d63c0920121c28f757cd8c0ac0849c8c87::erc {
    struct ERC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERC>(arg0, 9, b"ERC", b"ERC-NFT", b"Complex heads", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e90d694-10fc-4341-b234-28652724450a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERC>>(v1);
    }

    // decompiled from Move bytecode v6
}

