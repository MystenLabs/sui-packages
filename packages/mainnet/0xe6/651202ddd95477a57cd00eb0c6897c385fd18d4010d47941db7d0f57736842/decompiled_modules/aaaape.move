module 0xe6651202ddd95477a57cd00eb0c6897c385fd18d4010d47941db7d0f57736842::aaaape {
    struct AAAAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAPE>(arg0, 6, b"aaaApe", b"aaaAPE", b"Time to APE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaape_d34106e18f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

