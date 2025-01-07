module 0x714111b7322e7d586ea41ed4f0da73460639053773b2c271fd043be72d06787e::wcdognlad {
    struct WCDOGNLAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCDOGNLAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCDOGNLAD>(arg0, 6, b"WCDOGNLAD", b"WcDognlad Sui", b"This dogs like the meme king of WcDonalds.https://x.com/WcDognladSui | https://www.wcdognladsui.xyz | https://t.me/WcDognladSui_Channel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.wcdognladsui.xyz/images/2.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WCDOGNLAD>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCDOGNLAD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WCDOGNLAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

