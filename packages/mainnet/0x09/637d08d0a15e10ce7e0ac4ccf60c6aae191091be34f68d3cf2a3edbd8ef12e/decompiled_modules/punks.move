module 0x9637d08d0a15e10ce7e0ac4ccf60c6aae191091be34f68d3cf2a3edbd8ef12e::punks {
    struct PUNKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNKS>(arg0, 6, b"Punks", b"SuiPunks", x"31302c303030204e465420636f6c6c656374696f6e206c6976696e67206f6e202453756920706f7765726564206279202450554e4b20746f6b656e2c2063726561746564206279200a405375696c6c696f6e616972650a646567656e206d656d6520746f6b656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/punk_a3ed0728d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUNKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

