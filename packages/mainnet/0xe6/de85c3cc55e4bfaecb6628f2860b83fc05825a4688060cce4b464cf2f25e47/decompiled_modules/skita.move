module 0xe6de85c3cc55e4bfaecb6628f2860b83fc05825a4688060cce4b464cf2f25e47::skita {
    struct SKITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKITA>(arg0, 6, b"SKITA", b"SuiKita", x"48656c6c6f2c20496d20235355494b4954412020200a5348494241206769726c667269656e64204f6e202453554920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suikita9233_a26cc8b882.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

