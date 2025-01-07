module 0x24982fd13618e23702ff0bd6049e787207e5ece4a65031aecc0a64b2d221c86f::wukong {
    struct WUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUKONG>(arg0, 6, b"Wukong", b"WUKONG", x"4e6f772077652077696c6c206c616e642077756b6f6e67206f6e207375692e0a0a7765656b6c7920616e64206175746f6d61746963616c6c792c207363686f6f6c73206f662057554b4f4e477320696e207468652053756920636861696e207665726966792061646472657373657320686f6c64696e67202457554b4f4e4720696e2074686569722077616c6c6574732c200a0a466f722074686520746f70203130303020686f6c646572732c203130252077696c6c2062652072616e646f6d6c792073656c656374656420746f2070726f76696465207061737369766520696e636f6d6520696e202453554920616e64202457554b4f4e472e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wukongc_a_ae_e8f2b741ee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

