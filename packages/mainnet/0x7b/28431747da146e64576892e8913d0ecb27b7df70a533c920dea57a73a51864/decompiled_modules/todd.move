module 0x7b28431747da146e64576892e8913d0ecb27b7df70a533c920dea57a73a51864::todd {
    struct TODD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TODD>(arg0, 6, b"TODD", b"Peter Todd satoshi", b"New HBO documentary claims Peter Todd is Bitcoin creator Satoshi Nakamoto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000089_83a2399e0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TODD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TODD>>(v1);
    }

    // decompiled from Move bytecode v6
}

