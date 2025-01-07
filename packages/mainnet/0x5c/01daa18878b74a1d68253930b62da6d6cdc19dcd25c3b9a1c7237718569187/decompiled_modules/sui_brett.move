module 0x5c01daa18878b74a1d68253930b62da6d6cdc19dcd25c3b9a1c7237718569187::sui_brett {
    struct SUI_BRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_BRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_BRETT>(arg0, 9, b"Sui Brett", b"SBRETT", b"Sui Brett is a meme token on the Sui blockchain, inspired by the Brett meme. It offers a fun, community-driven experience with fast transactions and low fees.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843320288207093761/MIm1HMrA.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_BRETT>(&mut v2, 449000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_BRETT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_BRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

