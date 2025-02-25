module 0x8181cc1553cde82ccb4c9a0176d2bbeeb8dabec58ca7e7bb0df13c22d9682cb::mkc {
    struct MKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKC>(arg0, 6, b"MKC", b"MONKEY COIN", b"Monkey Coin is not just a regular meme coin but is building a truly valuable ecosystem. Developed on the BSC or Ethereum blockchain platform, Monkey Coin takes advantage of low transaction fees, fast processing speed and strong scalability. DeFi & Staking:", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/d56f4c18-1362-4c17-8406-d1ada5c2ba0e.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MKC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

