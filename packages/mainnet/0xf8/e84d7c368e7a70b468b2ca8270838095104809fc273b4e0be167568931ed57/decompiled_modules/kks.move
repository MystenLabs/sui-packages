module 0xf8e84d7c368e7a70b468b2ca8270838095104809fc273b4e0be167568931ed57::kks {
    struct KKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<KKS>(arg0, 9631926493164812138, b"Kekius on Sui", b"KKS", b"All ecosystems deserve equality. Let's make it happen with Elon Musk.", b"https://images.hop.ag/ipfs/QmcK9mCn7DtNZoyVZ6Mb55khyMoJkrWd5As5cKo27Y6T2V", 0x1::string::utf8(b"https://x.com/BarryRhein6395"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/@vinhsau95"), arg1);
    }

    // decompiled from Move bytecode v6
}

