module 0x6f0d1f5df34e14af53ca62c328d79bc7c392e9ca10707b55e50c62d940932df5::lack {
    struct LACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LACK>(arg0, 6, b"LACK", b"Mr.Luck", b"Mr.Luck - The mysterious gentelman in a black hat with a red ribbon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014791_4100614bf7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

