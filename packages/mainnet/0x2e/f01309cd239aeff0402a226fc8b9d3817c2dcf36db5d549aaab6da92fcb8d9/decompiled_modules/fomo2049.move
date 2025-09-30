module 0x2ef01309cd239aeff0402a226fc8b9d3817c2dcf36db5d549aaab6da92fcb8d9::fomo2049 {
    struct FOMO2049 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMO2049, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO2049>(arg0, 6, b"FOMO2049", b"2049 FUTURE OF MISSING OUT", b"$2049FOMO is the memecoin born from the future of missing out.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigkdszlknkx6rbgxi5td2esremvhi2jq274umm2lsiqb6gs7szjpy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO2049>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FOMO2049>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

