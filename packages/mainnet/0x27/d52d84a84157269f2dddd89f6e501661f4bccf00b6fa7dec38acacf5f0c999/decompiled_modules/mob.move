module 0x27d52d84a84157269f2dddd89f6e501661f4bccf00b6fa7dec38acacf5f0c999::mob {
    struct MOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOB>(arg0, 6, b"MOB", b"MOBFI", b"DONT BUY JUST ADS Play The game for free.! NFT IS OPTIONAL FOR AIRDROP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1743877273500.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

