module 0x5dc6989d927b928a99e89fab1055a612148dfca4b28f9d75b362e9fb21f7b00d::jaco {
    struct JACO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACO>(arg0, 6, b"JACO", b"The jaco", b"Have fun jaco", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieuvsrjwd6avdta4x5zdbaacb4qcr2xvfgpranagh6ecfsigoukzq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JACO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

