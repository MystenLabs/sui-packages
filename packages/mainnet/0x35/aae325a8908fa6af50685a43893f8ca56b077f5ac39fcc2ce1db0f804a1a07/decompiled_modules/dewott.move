module 0x35aae325a8908fa6af50685a43893f8ca56b077f5ac39fcc2ce1db0f804a1a07::dewott {
    struct DEWOTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEWOTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEWOTT>(arg0, 6, b"DEWOTT", b"Dewott on Sui", x"576f772c20616e6f74686572206c6f737420736f756c2068617320666f756e642069747320686172626f7221200a2057656c636f6d6520746f20746865207371756164206f6620277472656e642d636861736572732720616e642027726f617374696e672073757065726865726f6573272120486176652066756e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidu4czqwes4d5dwegiapo7ia64noxya72oj7fwe3o4kddc335zaaa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEWOTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DEWOTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

