module 0x14d9b27c4b8a00229803f1a4d73db21707ac1367a9fc485efdad75683ce43efb::niggatrump {
    struct NIGGATRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGATRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGATRUMP>(arg0, 6, b"NIGGATRUMP", b"NIGGA TRUMP", b"Trump, but hes black", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nigga_trump_06276443cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGATRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGATRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

