module 0xe2d3919a9076b52255f0ef49d5459d93356e8d62dae039b6e3ef1da72566c62c::sfn {
    struct SFN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SFN>(arg0, 11489418821981888176, b"Suifun", b"Sfn", b"Sfn Nft", b"https://images.hop.ag/ipfs/QmegML6fAPyfE4UEyudG8pc7xLMRjENaXkbkbb9KY4py4m", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

