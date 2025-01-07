module 0x740a0e6798b52d97facfbe7d5d799e77164d8d0221a2ce743b926a7ef48e66aa::mcd {
    struct MCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCD>(arg0, 6, b"MCD", b"MEME CUTURE BY DAVINCI", b"THE FIRST COIN OF THE LEGENDARY DAVINCI JEREMIE SUI. HERE YOU WILL FIND OUT ABOUT ALL THE ANALYSES OF THE MEME COINS THAT ARE PROMOTED BY DAVINCI. WHEN DAVINCI HAS HIS PUBLIC SUI WALLET, WE WILL SEND 50% OF THE COINS TO HIM.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001990_1b70e48775.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

