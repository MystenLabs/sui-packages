module 0x3f7c8e3da4499be71fb6019b7726b74c94c2c7482f5e61d863edd14cb4cecbdd::nalong {
    struct NALONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NALONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NALONG>(arg0, 6, b"Nalong", b"NalongSui", b"Ride the Wave of Fun and Fortune", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241010_171659_322_8df4ca3604.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NALONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NALONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

