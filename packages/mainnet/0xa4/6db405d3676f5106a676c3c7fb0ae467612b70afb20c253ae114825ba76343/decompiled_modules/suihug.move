module 0xa46db405d3676f5106a676c3c7fb0ae467612b70afb20c253ae114825ba76343::suihug {
    struct SUIHUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHUG>(arg0, 6, b"SUIHUG", b"Suihug", x"53756920487567202d2074686520706f70756c617220646f672066726f6d207468652053554920626c6f636b636861696e21206a6f696e2074686520636f6d6d756e6974792c20616e64206c657427732073686970207468697320746f6765746865722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069726_f53778dcfe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

