module 0x5aba5d35a6dbd048993fa8a64d0d6b176542b5331ddcb6ac53fbf4a25962ef31::hanabi {
    struct HANABI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANABI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANABI>(arg0, 9, b"HANABI", b"Hanabi", x"23e7a78be794b0e78aac2023e995b7e6af9be7a8ae2023e78aace381aee38184e3828be697a5e5b8b82023e695a3e6ada9e5a4a7e5a5bde3818d2023e79992e38197e78aac2023e3839ee3839e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x67e610a7b7e7ab766e06301c676f84590e5256a7.png?size=lg&key=5baacc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HANABI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANABI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANABI>>(v1);
    }

    // decompiled from Move bytecode v6
}

