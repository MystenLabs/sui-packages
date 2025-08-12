module 0xf6d8f3ef3928784a3332bf68830a93c89dcbf68c412deae8ef6c28c725c9c01a::fajke {
    struct FAJKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAJKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAJKE>(arg0, 6, b"Fajke", b"Fake Toklen", b"FakeT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAJKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FAJKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

