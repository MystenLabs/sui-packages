module 0x6deb6e1f34f418f021c5b965307ac4dee23470830d98d26f9d597c169bf708c2::tutu {
    struct TUTU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUTU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUTU>(arg0, 6, b"TUTU", b"TUTU Token", b"This is a test token, dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUTU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TUTU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

