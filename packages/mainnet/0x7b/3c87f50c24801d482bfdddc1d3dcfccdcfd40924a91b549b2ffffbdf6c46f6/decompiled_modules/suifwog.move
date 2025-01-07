module 0x7b3c87f50c24801d482bfdddc1d3dcfccdcfd40924a91b549b2ffffbdf6c46f6::suifwog {
    struct SUIFWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFWOG>(arg0, 6, b"SuiFWOG", b"FWOG on SUI", b"FWOG from SUI. PEPE's good friend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_09_30_58_66505716f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

