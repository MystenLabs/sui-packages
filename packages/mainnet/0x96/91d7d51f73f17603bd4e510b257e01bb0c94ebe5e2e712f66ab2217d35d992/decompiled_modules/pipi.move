module 0x9691d7d51f73f17603bd4e510b257e01bb0c94ebe5e2e712f66ab2217d35d992::pipi {
    struct PIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPI>(arg0, 6, b"PIPI", b"PIPIonsui", x"5375692c207468652066756e6e696573742064726f70206f66207761746572206f6e2074686520696e7465726e65742e0a0a4672657368206d656d65732c206e6f2d66696c746572206a6f6b65732c20616e64206120636f6d6d756e6974792074686174206b6e6f7773206c6966652069732062657474657220776974682068756d6f722e202023706970697669626573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_05_alle_00_52_45_9b7ea4e2f5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

