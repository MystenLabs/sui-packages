module 0xfdf343cd83d6a5bd7fa8297b6420a8bdc0601d2ff6d156de37891380883da5ad::lwh {
    struct LWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LWH>(arg0, 6, b"LWH", b"luce wif hat", b"Just luce wif hat, We're gonna rock the whole world, come on", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241201_104723_437_172a3f719a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

