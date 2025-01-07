module 0x1dc4f6e2463f96d7f9640145ea1ae46550dbf355e5bea2ff18e8fea781790917::sor {
    struct SOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOR>(arg0, 9, b"SOR", b"Sorra", b"Sorra is the premier decentralized platform for tokenized real estate and hospitality, empowering users with fractional ownership of high-value properties while redefining the way we rent, host, and invest.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xe021baa5b70c62a9ab2468490d3f8ce0afdd88df.png?size=xl&key=e9eeae")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

