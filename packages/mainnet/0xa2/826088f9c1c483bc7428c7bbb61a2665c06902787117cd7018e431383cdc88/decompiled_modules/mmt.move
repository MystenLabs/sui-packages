module 0xa2826088f9c1c483bc7428c7bbb61a2665c06902787117cd7018e431383cdc88::mmt {
    struct MMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MMT>(arg0, 9, b"MMT", b"MMT", b"MMT is the native governance token for Momentum, the operating system powering the next era of global finance. MMT empowers holders to govern the protocol through vote-escrowed staking (veMMT) for community-driven decisions within the Momentum ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://momentum-statics.s3.us-west-1.amazonaws.com/MMT.png")), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MMT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

