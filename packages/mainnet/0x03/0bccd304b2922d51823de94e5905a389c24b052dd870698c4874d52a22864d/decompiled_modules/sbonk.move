module 0x30bccd304b2922d51823de94e5905a389c24b052dd870698c4874d52a22864d::sbonk {
    struct SBONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBONK>(arg0, 9, b"Sui Bonk", b"SBONK", b"MAKE MEME GREATE AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1842571553386770432/WBVoqMeh_400x400.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBONK>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SBONK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBONK>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

