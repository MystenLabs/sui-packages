module 0x3d28ff75f07134eb5ae633c9b71c09d92b1765c272d5ba0b7b29b323019b021a::taw {
    struct TAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAW>(arg0, 9, b"TAW", b"The Acid Walrus", x"43727970746f20646567656e2e20204765656b2c20416369642c2057616c7275732e0a486973746f726963616c204d657461766572736520636861726163746572206578706c6f72696e672074686520537569206e6574776f726b2e20476f6f20676f6f206727206a6f6f6221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f1ac68e4b7dc719484cfe1f25367e6b6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

