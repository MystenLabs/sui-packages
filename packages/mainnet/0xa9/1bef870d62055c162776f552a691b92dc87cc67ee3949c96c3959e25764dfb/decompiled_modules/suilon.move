module 0xa91bef870d62055c162776f552a691b92dc87cc67ee3949c96c3959e25764dfb::suilon {
    struct SUILON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILON>(arg0, 6, b"SUILON", b"Dark Elon", b"Dark Elon Musk, the blue laser eyes stay on till 50bill market cap on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DARKELON_67acb511ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILON>>(v1);
    }

    // decompiled from Move bytecode v6
}

