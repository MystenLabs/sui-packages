module 0x9598830cbe7b2ca883b5f411fcf405d2512bd9d33dde19c00564fcfe4862f3ee::bluedoge {
    struct BLUEDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEDOGE>(arg0, 9, b"BLUEDOGE", b"Blue Doge", b"Doge is meme First in BlockChain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1845104994724478979/wleHLCn2.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUEDOGE>(&mut v2, 4660000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEDOGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

