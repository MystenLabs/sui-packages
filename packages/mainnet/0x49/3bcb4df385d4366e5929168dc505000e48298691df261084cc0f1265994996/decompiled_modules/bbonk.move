module 0x493bcb4df385d4366e5929168dc505000e48298691df261084cc0f1265994996::bbonk {
    struct BBONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBONK>(arg0, 9, b"BBONK", b"BabyBonk on Sui", b"BabyBonk on Sui is a meme coin with a strong community focus, inspired by the iconic BabyBonk. With zero taxes and a fair launch, it's designed for fun and growth on the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://postimg.cc/7J1cyYyc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BBONK>(&mut v2, 9900000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBONK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

