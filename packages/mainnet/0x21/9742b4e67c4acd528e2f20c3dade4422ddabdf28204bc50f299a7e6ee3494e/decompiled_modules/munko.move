module 0x219742b4e67c4acd528e2f20c3dade4422ddabdf28204bc50f299a7e6ee3494e::munko {
    struct MUNKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUNKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUNKO>(arg0, 6, b"MUNKO", b"Munko On Sui", x"6d756e6b6f2069732061206d6f6e6b65792077697468206120706c616e2e2e0a6d756e6b6f277320706c616e20697320746f0a73686f77206576657279626f6479207468617420746865726520617265207465616d730a7468617420617265207374696c6c2077696c6c696e6720746f200a737469636b207468696e6773206f757420616e642072756e20612070726f6a656374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048754_2f314c649b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUNKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

