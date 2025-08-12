module 0x78493f70c43047367fef7fd7e6fe9fb5d0dd6cc2227bc6d7361dacb3f67a3883::stg {
    struct STG has drop {
        dummy_field: bool,
    }

    fun init(arg0: STG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STG>(arg0, 6, b"STG", b"SuisterGO", x"5375697374657220476f2069732061207765622d626173656420506c61792d746f2d4561726e20285032452920626c6f636b636861696e2067616d65206275696c74206f6e20746865206661737420616e64207363616c61626c6520535549204e6574776f726b2e0a0a497420636f6d62696e657320636f6c6c65637469626c652067616d696e67207769746820737472617465676963207465616d206275696c64696e6720616e6420636f6d706574697469766520626174746c65732020616c6c20737570706f727465642062792061206361726566756c6c792064657369676e65642c206465666c6174696f6e61727920746f6b656e2065636f6e6f6d792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibvvtnkbzdolk5z56sshd35w2llpgy2za6dogfwxig7xfu7zx7whu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

