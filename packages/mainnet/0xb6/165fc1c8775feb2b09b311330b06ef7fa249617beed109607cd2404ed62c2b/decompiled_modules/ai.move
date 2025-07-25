module 0xb6165fc1c8775feb2b09b311330b06ef7fa249617beed109607cd2404ed62c2b::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI>(arg0, 6, b"AI", b"ANY INU", b"Any Inu: The First Omnichain Dogcoin Powered by Axelar's ITS (Interchain Token Service) is now live on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihlqibozbaanu2qg3b6hkgrvbthwzhd2klkz2nkrs7xkyjrpgvgbe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

