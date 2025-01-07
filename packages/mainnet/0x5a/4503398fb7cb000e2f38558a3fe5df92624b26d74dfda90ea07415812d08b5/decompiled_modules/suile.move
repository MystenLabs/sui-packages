module 0x5a4503398fb7cb000e2f38558a3fe5df92624b26d74dfda90ea07415812d08b5::suile {
    struct SUILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILE>(arg0, 6, b"SUILE", b"Sui Elephant", x"496e20746865207661737420616e642064796e616d696320657870616e7365206f66207468652063727970746f2077696c6465726e6573732c2074686572652073747269646573206120626f6c6420616e64206368617269736d6174696320666967757265206b6e6f776e2073696d706c792061732053756920456c657068616e74732e200a0a456c657068616e747320617265207361637265642e204a656574732077696c6c2062652070756e69736865642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_06_05_13_48_42_5_b986d95cca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILE>>(v1);
    }

    // decompiled from Move bytecode v6
}

