module 0x2b4ad089e5035a402b57cb18261222ef0cd479e9ddf1e244caa47c09f66d27e::wet {
    struct WET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WET>(arg0, 6, b"WET", b"WETCOIN", b"Stake. Splash. Soak it in. WETCOIN is here on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicyr3uj7a2nw5giyjvtay3rdthk77myeivg4ho7conpxq5i3hgq7q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

