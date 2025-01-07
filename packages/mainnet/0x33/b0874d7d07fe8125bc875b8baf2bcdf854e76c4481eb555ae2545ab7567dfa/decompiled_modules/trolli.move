module 0x33b0874d7d07fe8125bc875b8baf2bcdf854e76c4481eb555ae2545ab7567dfa::trolli {
    struct TROLLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLLI>(arg0, 6, b"TROLLI", b"Trolli on Sui", b"Trolli https://t.me/trolliportal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241219_152254_807_b0af0b6384.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROLLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

