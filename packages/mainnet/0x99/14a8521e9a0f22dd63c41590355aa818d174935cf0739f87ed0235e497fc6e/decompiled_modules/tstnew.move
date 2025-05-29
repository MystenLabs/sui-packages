module 0x9914a8521e9a0f22dd63c41590355aa818d174935cf0739f87ed0235e497fc6e::tstnew {
    struct TSTNEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTNEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTNEW>(arg0, 6, b"TSTNEW", b"TSTNEW Token", b"This is a test token new", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTNEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSTNEW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

