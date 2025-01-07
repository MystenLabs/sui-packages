module 0xb125f188771f3450767f04144b0c379bf7c3236b94b04182d52b595fd14f5900::borb {
    struct BORB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORB>(arg0, 6, b"BORB", b"BORB MEME", x"24424f524220626f726e206865726520746f20656d626f646965732068756d6f722c2066726565646f6d2c20616e642074686520737472656e677468206f6620636f6d6d756e6974790a0a24424f52422077696c6c206275696c64206d656d652067656e657261746f72206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bork_ok_a11f0bc379.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORB>>(v1);
    }

    // decompiled from Move bytecode v6
}

