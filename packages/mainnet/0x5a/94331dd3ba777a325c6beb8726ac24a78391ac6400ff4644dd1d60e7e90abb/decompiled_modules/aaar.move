module 0x5a94331dd3ba777a325c6beb8726ac24a78391ac6400ff4644dd1d60e7e90abb::aaar {
    struct AAAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAR>(arg0, 6, b"AAAR", b"AAAARAT ON SUI", b"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b4b80da953b442bb9e5cd31393ce3b9a_013917b7f9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

