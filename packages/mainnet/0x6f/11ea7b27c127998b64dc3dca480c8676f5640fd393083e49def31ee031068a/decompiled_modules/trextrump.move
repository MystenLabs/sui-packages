module 0x6f11ea7b27c127998b64dc3dca480c8676f5640fd393083e49def31ee031068a::trextrump {
    struct TREXTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREXTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREXTRUMP>(arg0, 6, b"TREXTRUMP", b"T-Rex Trump", b"His hands are HUGE. Extinction events and meteors are fake news. Only on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004179_cd0f70436e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREXTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREXTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

