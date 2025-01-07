module 0x847df4eb3266c91fe249fb0557ddb6f024cf87e087f429c70572d9c23b1a6659::gobrr {
    struct GOBRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOBRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOBRR>(arg0, 6, b"GOBRR", b"GO BRR", x"474f20425252206f7220474f20484f4d450a496e6e6f766174697665204d656d652050726f6a6563742064726976656e20627920636f6d6d756e69747920737563636573730a45616368206d61726b657420636170206d696c6573746f6e6520756e6c6f636b20612064656c6976657261626c650a546865206d6f726520796f75204252522020746865206d6f7265207765206275696c6420212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_1_da73a456d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOBRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOBRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

