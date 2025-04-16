module 0x3f758acf40e8fbe8672daf8b8b5581061ca920de69982e1f6aba265be9ec3e3a::dmop {
    struct DMOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMOP>(arg0, 6, b"DMOP", b"DOG MOP Token", b"Dont Buy for Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DMOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

