module 0x839c6ccf080e0ed15e18d4046c999a8be61515be9dac7f406b87ae4b5f1a85a5::ecoaieco {
    struct ECOAIECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECOAIECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECOAIECO>(arg0, 6, b"ECOAIECO", b"$ECO AI", x"45636f416c3a20416c2d64726976656e206167656e74732065636f73797374656d206372656174696e6720696e6e6f766174697665207574696c69746965732c2067656e65726174696e6720726576656e75652c20616e642070726f6d6f74696e67207375737461696e6162696c6974792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_CW_Ofs_EG_400x400_e49ca8ed23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECOAIECO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECOAIECO>>(v1);
    }

    // decompiled from Move bytecode v6
}

