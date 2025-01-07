module 0x3abb2a1e5f5dd7281bd47e5e4df510dd86c15d09de4c8748369013fbe8db742f::bkr {
    struct BKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKR>(arg0, 6, b"BKR", b"SUIBAKER", b"Not enough yeast on this DEX for the amount of bread we gonna make.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4bc84ca7_357c_4faa_906c_1d8230f8801b_d9c847e876.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BKR>>(v1);
    }

    // decompiled from Move bytecode v6
}

