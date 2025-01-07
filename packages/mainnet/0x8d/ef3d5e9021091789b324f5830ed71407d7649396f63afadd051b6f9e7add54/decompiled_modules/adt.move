module 0x8def3d5e9021091789b324f5830ed71407d7649396f63afadd051b6f9e7add54::adt {
    struct ADT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADT>(arg0, 9, b"ADT", b"Airdrop Test", b"ADT Airdrop Test", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ADT>(&mut v2, 69420000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADT>>(v1);
    }

    // decompiled from Move bytecode v6
}

