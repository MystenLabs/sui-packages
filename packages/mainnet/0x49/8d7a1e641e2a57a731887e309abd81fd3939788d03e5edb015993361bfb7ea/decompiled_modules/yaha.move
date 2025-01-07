module 0x498d7a1e641e2a57a731887e309abd81fd3939788d03e5edb015993361bfb7ea::yaha {
    struct YAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAHA>(arg0, 6, b"YAHA", b"Yaha", b"I promise.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chomp_0da74277f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

