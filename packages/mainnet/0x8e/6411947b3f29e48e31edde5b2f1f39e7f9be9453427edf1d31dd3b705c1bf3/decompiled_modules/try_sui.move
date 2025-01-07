module 0x8e6411947b3f29e48e31edde5b2f1f39e7f9be9453427edf1d31dd3b705c1bf3::try_sui {
    struct TRY_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRY_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRY_SUI>(arg0, 9, b"TRY_SUI", b"Wanna Try Sui Move", b"Hey Man, I build on Sui. Wanna Try Sui Move?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/V2ShyBx.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRY_SUI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRY_SUI>>(v2, @0x96d9a120058197fce04afcffa264f2f46747881ba78a91beb38f103c60e315ae);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRY_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

