module 0xbc73968da5321337f05c024b97c79bca73926af6db7648b3a8ca048235dbae81::sbomb {
    struct SBOMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOMB>(arg0, 6, b"SBomb", b"Bomb", x"426f6d622069732061204d656d6520546f6b656e20666f72207468652053756920426c6f636b636861696e2e0a57652077616e6e61206272696e6720736f6d6520426f6d62205761766573206f6e20537569206c6574277320746865204a6f75726e657920626567696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054110_5601d612b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBOMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

