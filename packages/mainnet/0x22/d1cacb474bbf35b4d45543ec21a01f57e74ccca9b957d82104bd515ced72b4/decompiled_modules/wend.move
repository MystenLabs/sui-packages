module 0x22d1cacb474bbf35b4d45543ec21a01f57e74ccca9b957d82104bd515ced72b4::wend {
    struct WEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEND>(arg0, 9, b"WEND", b"Wen Dexscreener ", b"Wen Dexscreener integration", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://turquoise-eldest-swan-531.mypinata.cloud/ipfs/QmQzwA25EUkPN8oNiWw8qWmXgH6zqEq24Gn7UdAkexBoVX")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WEND>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEND>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

