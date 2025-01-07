module 0x6728da28326eece455d40961323c904b159bea8f504b6530c7bacc9adb09be47::blm {
    struct BLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLM>(arg0, 9, b"BLM", b"Bloom", x"426c6f6f6d20546f6b656e206973206120646563656e7472616c697a656420746f6b656e206f6e2074686520536f6c616e6120626c6f636b636861696e2c20737570706f7274696e6720666c6f776572206167726963756c7475726973747320616e642067617264656e6572732e2055736572732063616e2065786368616e6765206669617420666f7220426c6f6f6d20746f6b656e7320616e6420637265617465204e465473206f6620746865697220666c6f7765722070726f64756374732c20656e68616e63696e67206f70706f7274756e697469657320696e20746865206469676974616c206d61726b6574706c6163652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/977e9a63-838b-49ee-b932-c7aefeb72f3f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

