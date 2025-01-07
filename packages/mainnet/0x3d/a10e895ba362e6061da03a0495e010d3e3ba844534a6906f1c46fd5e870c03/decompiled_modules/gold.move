module 0x3da10e895ba362e6061da03a0495e010d3e3ba844534a6906f1c46fd5e870c03::gold {
    struct GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLD>(arg0, 6, b"Gold", b"Goldy", b"\"Before having a dog, you can't imagine what it would be like to live with them; after, you can't imagine life without them.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Dogs_copy_3d272e0cea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

