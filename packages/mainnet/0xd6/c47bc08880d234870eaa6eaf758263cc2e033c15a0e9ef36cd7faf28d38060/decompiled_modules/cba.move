module 0xd6c47bc08880d234870eaa6eaf758263cc2e033c15a0e9ef36cd7faf28d38060::cba {
    struct CBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBA>(arg0, 6, b"CBA", b"cba", b"This is CBA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_b028ad79aa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

