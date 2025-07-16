module 0xe12df353537b5c6c3f8d482c4b354ed79cec046c525d9ea4783562c150ec0390::wid {
    struct WID has drop {
        dummy_field: bool,
    }

    fun init(arg0: WID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WID>(arg0, 6, b"WID", b"catwidhat", b"chillin on sui wid homies, reppin da water chain drip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiam7qw3ifn52kaxz7bbeg32fzhensicnpojh2phxtnnzq7qluzjze")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WID>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

