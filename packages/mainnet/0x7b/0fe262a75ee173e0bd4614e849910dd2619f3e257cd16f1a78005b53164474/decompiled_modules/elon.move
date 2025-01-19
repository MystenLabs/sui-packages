module 0x7b0fe262a75ee173e0bd4614e849910dd2619f3e257cd16f1a78005b53164474::elon {
    struct ELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELON>(arg0, 6, b"Elon", b"Elonmusk", b"It's an unofficial token, just entertainment, a salute to Elon Musk, a salute to Donald Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sod5od_9c91b63462.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

