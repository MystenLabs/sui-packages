module 0x242f828e5e39588eb018f80b9b6c6709010cfef7ac1b57ccbb415c5fbff3635c::safe {
    struct SAFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAFE>(arg0, 9, b"SAFE", b"Sui Safe M00NS", b"Moons that are safe from outer space whales", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.midjourney.com/bafdb0e2-da5b-4627-aa4f-54a62f88706c/0_1.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAFE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAFE>>(v2, @0xfa35f2a535d78a65e8d67cda3a7bcb07cf20c18d87f8f7459b8ae4257a7991d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

