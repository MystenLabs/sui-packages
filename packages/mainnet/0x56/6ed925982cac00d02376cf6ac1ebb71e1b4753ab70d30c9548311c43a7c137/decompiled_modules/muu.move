module 0x566ed925982cac00d02376cf6ac1ebb71e1b4753ab70d30c9548311c43a7c137::muu {
    struct MUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUU>(arg0, 6, b"MUU", b"Muu On Sui", x"5361792068656c6c6f20746f206d757521206865277320796f7572206e657720637574650a667269656e64206f6e20737569204e6574776f726b2120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033633_0c79c73798.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

