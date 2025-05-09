module 0x543e9ec6464cd1610839b9dfc7153013ee620e1540383c151731ef712d54929a::srm {
    struct SRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRM>(arg0, 6, b"SRM", b"SUI REWARDS ME", b"The first REWARDS DEX on Sui. Earn $SUI just for holding $SRM. Launch your own. Creator royalties fund growth. Built to reward.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigsf7bfopnihaov4s3yqr3rqkasp43zxsantjudfqnib277sz3qr4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SRM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

