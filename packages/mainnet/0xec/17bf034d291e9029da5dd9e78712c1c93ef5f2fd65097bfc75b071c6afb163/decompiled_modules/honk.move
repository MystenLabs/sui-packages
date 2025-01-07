module 0xec17bf034d291e9029da5dd9e78712c1c93ef5f2fd65097bfc75b071c6afb163::honk {
    struct HONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONK>(arg0, 9, b"HONK", b"HONK", b"The mischievous goose ready to wreak havoc on the blockchain! Inspired by the \"Mess with the Honk, Get the Bonk\" meme, this feathered rebel isn't afraid to ruffle some feathers.  https://honksui.fun  https://twitter.com/sui_honk  https://t.me/honk_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/honksui/honk/refs/heads/main/image_2024-10-15_01-54-11.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HONK>(&mut v2, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

