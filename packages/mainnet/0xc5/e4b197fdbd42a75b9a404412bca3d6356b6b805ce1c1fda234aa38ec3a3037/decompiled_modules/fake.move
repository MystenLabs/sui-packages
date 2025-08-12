module 0xc5e4b197fdbd42a75b9a404412bca3d6356b6b805ce1c1fda234aa38ec3a3037::fake {
    struct FAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKE>(arg0, 6, b"Fake", b"FakeTo", b"Dontbuy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FAKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

