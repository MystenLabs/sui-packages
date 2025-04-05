module 0xdbfad2bee71847ca93d713cf600ebd3a681e7a13549d7d2ae620be468d95f50f::mixdog {
    struct MIXDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIXDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIXDOG>(arg0, 6, b"MIXDOG", b"MIX", b"MIXDOG is the king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIXDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIXDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

