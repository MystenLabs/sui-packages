module 0x8931ce285514a392a3b959b8adbb8590a8d98966cc91483ce2d5db559d7fdccd::suibot {
    struct SUIBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOT>(arg0, 6, b"SuiBot", b"Sui AI Bot", b"Neo, the Sui AI Robot, here to chill, here for the thrill. Vibezzzzz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1592_b05146614c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

