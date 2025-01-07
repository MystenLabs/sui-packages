module 0xb65863a8d820eeb0b624c1c71402156f4721c0f0890fc8d79d545f4d01c8ce87::chummy {
    struct CHUMMY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHUMMY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHUMMY>>(0x2::coin::mint<CHUMMY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CHUMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUMMY>(arg0, 6, b"Chummy", b"Chummy Chum Chums", b"meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F5a7fecce_23d5_4dd9_b174_40c234520d5a_b2a4ade691.jfif&w=640&q=75"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHUMMY>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHUMMY>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUMMY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

