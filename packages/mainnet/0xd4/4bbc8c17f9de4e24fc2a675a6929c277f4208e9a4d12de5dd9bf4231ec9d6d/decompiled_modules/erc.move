module 0xd44bbc8c17f9de4e24fc2a675a6929c277f4208e9a4d12de5dd9bf4231ec9d6d::erc {
    struct ERC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERC>(arg0, 9, b"ERC", b"ERC-NFT", b"Complex heads", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f222e9c0-0831-469a-a3e5-3da9f7d7844d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERC>>(v1);
    }

    // decompiled from Move bytecode v6
}

