module 0x9168be818d1ae12de2e1515ed059fa74d4c20520578bae014900149f49599c1::mistdoxl {
    struct MISTDOXL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISTDOXL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISTDOXL>(arg0, 6, b"MISTDOXl", b"MISTDOX", b"MISTDOX is the king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISTDOXL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MISTDOXL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

