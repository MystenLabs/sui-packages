module 0xb9dcd876a766e88c33c9aa002c97621a362eba603d7e525c303c102e876dd048::test1 {
    struct TEST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST1>(arg0, 9, b"TEST1", b"test11", b"https://gateway.pinata.cloud/ipfs/QmaqUF1XDhiA2bvu4e1YaU8N3V2ai41DnT9MTvv5BeFZXK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmZJeihvHNYCewR8VHnCij4ArXX3CkHR9Mo76onaVwE2GH")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST1>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

