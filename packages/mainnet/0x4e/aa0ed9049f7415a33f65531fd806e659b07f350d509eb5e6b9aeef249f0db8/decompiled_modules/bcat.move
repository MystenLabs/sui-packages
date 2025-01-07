module 0x4eaa0ed9049f7415a33f65531fd806e659b07f350d509eb5e6b9aeef249f0db8::bcat {
    struct BCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCAT>(arg0, 6, b"BCAT", b"BABYCAT SUI", b"BabyCat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004227_82741a515c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

