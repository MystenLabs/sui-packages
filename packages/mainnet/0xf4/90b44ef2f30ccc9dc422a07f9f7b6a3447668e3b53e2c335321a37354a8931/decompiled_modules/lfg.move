module 0xf490b44ef2f30ccc9dc422a07f9f7b6a3447668e3b53e2c335321a37354a8931::lfg {
    struct LFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFG>(arg0, 9, b"LFG", b"SUILFG", b"The adorable little brother of SUILFG. Small bags, big dreams", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreidmd4pfiqwzvv5dytavbab6k44nzoo55bvryxp5e2xfevxdmimzn4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LFG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

