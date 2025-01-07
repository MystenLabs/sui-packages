module 0x521d470e5d76138f6b84977e0e88d2b3571fd6f08e8899bf26a396f49d2d9d23::backpack {
    struct BACKPACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACKPACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACKPACK>(arg0, 9, b"BACKPACK", b"BCKPCKSUI", b"The Sui ecosystem will soon have access to Backpack Exchange, the Backpack non-custodial wallet, and Mad Lads, the top NFT community in the Solana ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a016c02-2f19-4572-9be0-583ccbd4f570.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACKPACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BACKPACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

