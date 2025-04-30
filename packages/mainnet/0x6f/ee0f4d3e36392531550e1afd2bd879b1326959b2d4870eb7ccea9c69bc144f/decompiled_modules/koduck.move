module 0x6fee0f4d3e36392531550e1afd2bd879b1326959b2d4870eb7ccea9c69bc144f::koduck {
    struct KODUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KODUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KODUCK>(arg0, 6, b"Koduck", b"Koduck On Sui", x"4b6f6475636b2069732061206d656d65636f696e20696e73706972656420627920506f6b6d6f6e73205073796475636b2c206272696e67696e672074686520756e6971756520656e65726779206f662074686520537569204e6574776f726b2e200a0a436f6d62696e696e672074686520706f776572206f66206d656d657320616e64207468652066756e206f662074686520506f6b6d6f6e20756e6976657273652c204b6f6475636b2069732074686520636f696e20796f7520646f6e74206e65656420746f20756e6465727374616e642c206275742077696c6c206c6f766520746f206861766521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Generated_Image_2_b54fcbb191.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KODUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KODUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

