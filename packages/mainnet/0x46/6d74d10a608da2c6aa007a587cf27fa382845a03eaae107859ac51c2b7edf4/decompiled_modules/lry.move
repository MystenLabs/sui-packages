module 0x466d74d10a608da2c6aa007a587cf27fa382845a03eaae107859ac51c2b7edf4::lry {
    struct LRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LRY>(arg0, 6, b"LRY", b"Sui Larry", b"Just a LRY guy, if you need help? contact $LRY, he is a kind life saver", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250506_192100_367316a593.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

