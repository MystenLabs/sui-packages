module 0x8539b50ce8bd96cf56749d5900ff1d89f45bafb50327c8fce60b1b71beba542f::bdac {
    struct BDAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDAC>(arg0, 6, b"BDAC", b"Billionaire Degen Ape Club", b"Want to stay ahead in crypto?  Join Degenaires for exclusive updates on the hottest projects, airdrops, NFTs, and more! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bdac_logo_md_9e8d534a47.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

