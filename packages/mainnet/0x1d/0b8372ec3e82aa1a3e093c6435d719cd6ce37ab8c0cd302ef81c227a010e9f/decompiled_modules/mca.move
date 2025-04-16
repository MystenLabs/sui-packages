module 0x1d0b8372ec3e82aa1a3e093c6435d719cd6ce37ab8c0cd302ef81c227a010e9f::mca {
    struct MCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCA>(arg0, 6, b"MCA", b"MCA Token", b"MCA for Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MCA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

