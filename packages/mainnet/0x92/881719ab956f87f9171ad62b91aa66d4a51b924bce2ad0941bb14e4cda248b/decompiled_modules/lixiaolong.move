module 0x92881719ab956f87f9171ad62b91aa66d4a51b924bce2ad0941bb14e4cda248b::lixiaolong {
    struct LIXIAOLONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIXIAOLONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIXIAOLONG>(arg0, 6, b"Lixiaolong", b"Bruce Lee", b"A generation of grandmasters, famous actors, and eternal kung fu emperors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727881663688_3142212552.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIXIAOLONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIXIAOLONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

