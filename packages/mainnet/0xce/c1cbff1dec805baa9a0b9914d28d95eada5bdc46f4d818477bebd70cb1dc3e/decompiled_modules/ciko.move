module 0xcec1cbff1dec805baa9a0b9914d28d95eada5bdc46f4d818477bebd70cb1dc3e::ciko {
    struct CIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIKO>(arg0, 6, b"CIKO", b"ciko the cat", b"THE DOG DAYS ARE OVER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000119234_4c17ecff6d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

