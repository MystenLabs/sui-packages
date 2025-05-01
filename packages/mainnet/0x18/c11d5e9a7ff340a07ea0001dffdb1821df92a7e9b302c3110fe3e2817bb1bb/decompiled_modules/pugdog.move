module 0x18c11d5e9a7ff340a07ea0001dffdb1821df92a7e9b302c3110fe3e2817bb1bb::pugdog {
    struct PUGDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGDOG>(arg0, 6, b"PUGDOG", b"PUGDOG Token", b"PUGDOG is the fake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUGDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

