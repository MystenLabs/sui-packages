module 0xe782cdcd4f7fe7abe546cf0350c05afedafd2b97742b0683a4332d19f20344b2::ice {
    struct ICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICE>(arg0, 6, b"ICE", b"SUIce", b"SUIce, The Chillest Memecoin on SUI Forged in frost, powered by SUI. SUIce freezes FUD, melts charts, and brings icy vibes to the blockchain. Cold & Clean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifq2sjwfvk6v57zc53xim5fm5elcwy7fycbxkdi2gephwoloiehbu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ICE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

