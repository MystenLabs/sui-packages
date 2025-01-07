module 0x8e3c870afcaa10fa4d997c564826f32d544b2f552ca954d3d75ca712345a138a::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 9, b"SUI", b"Super Useful Infra", b"SUI = Super Useful Infra", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/c2lWq8K.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v2, @0x96d9a120058197fce04afcffa264f2f46747881ba78a91beb38f103c60e315ae);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

