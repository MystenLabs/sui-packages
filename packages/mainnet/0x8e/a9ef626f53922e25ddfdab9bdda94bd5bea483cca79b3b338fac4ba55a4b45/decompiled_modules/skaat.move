module 0x8ea9ef626f53922e25ddfdab9bdda94bd5bea483cca79b3b338fac4ba55a4b45::skaat {
    struct SKAAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKAAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKAAT>(arg0, 6, b"SKAAT", b"Sui Kaat", x"5375696b61617420436f696e20697320796f7572207469636b657420746f206120706177736f6d6520616476656e7475726520696e207468650a63727970746f20776f726c642120496e7370697265642062792074686520636861726d20616e6420706c617966756c6e657373206f66206f75720a66756e2d6c6f76696e67206361742c204b6161742c2074686973206d656d6520636f696e2069736e2774206a7573742061626f7574206e756d62657273200a697427732061626f7574206372656174696e67206120636f6d6d756e6974792077686572652065766572796f6e652063616e206c617567682c0a636f6e6e6563742c20616e642067726f7720746f6765746865722e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009317_f3dfcafb8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKAAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKAAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

