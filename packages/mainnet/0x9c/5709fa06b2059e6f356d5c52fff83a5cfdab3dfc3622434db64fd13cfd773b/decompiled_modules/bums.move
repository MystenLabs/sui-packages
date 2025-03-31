module 0x9c5709fa06b2059e6f356d5c52fff83a5cfdab3dfc3622434db64fd13cfd773b::bums {
    struct BUMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMS>(arg0, 6, b"BUMS", b"Bums Airdrop", b"last 25 days. come and get it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000622_1b9d006d9e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

