module 0xfcee3163def4fc5fb5a28c5f21597ddf30f11207d51a5b95a2d9f36332dd6fa3::ftrump {
    struct FTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTRUMP>(arg0, 6, b"FTRUMP", b"Fud Trump", b"Fud the Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240912_133316_b6022bbc2c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

