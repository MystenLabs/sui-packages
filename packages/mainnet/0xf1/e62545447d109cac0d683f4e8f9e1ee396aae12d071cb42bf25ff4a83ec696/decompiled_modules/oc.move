module 0xf1e62545447d109cac0d683f4e8f9e1ee396aae12d071cb42bf25ff4a83ec696::oc {
    struct OC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OC>(arg0, 6, b"OC", b"One Coin", b"What if we all drop 1 SUI ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic6toit44ebbrg2ubdjxsn5cujnz4qqzayg7ul722t2go7zs27ny4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

