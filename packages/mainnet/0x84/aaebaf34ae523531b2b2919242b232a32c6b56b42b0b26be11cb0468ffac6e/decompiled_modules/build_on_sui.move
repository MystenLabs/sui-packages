module 0x84aaebaf34ae523531b2b2919242b232a32c6b56b42b0b26be11cb0468ffac6e::build_on_sui {
    struct BUILD_ON_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUILD_ON_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUILD_ON_SUI>(arg0, 9, b"BUILD_ON_SUI", b"I'm Building On Sui", b"Yo! I'm Building On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/SOOlpQW.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUILD_ON_SUI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUILD_ON_SUI>>(v2, @0x96d9a120058197fce04afcffa264f2f46747881ba78a91beb38f103c60e315ae);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUILD_ON_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

