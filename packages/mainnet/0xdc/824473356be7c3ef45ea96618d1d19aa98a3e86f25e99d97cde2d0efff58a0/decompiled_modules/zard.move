module 0xdc824473356be7c3ef45ea96618d1d19aa98a3e86f25e99d97cde2d0efff58a0::zard {
    struct ZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZARD>(arg0, 6, b"ZARD", b"Suizard", x"45766572796f6e652773206661766f7269746520506f6bc3a96d6f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib47m2yiwgfqw2shjqei5i3cttumwc7xvzy5wkyzkcztzrz4tnq3i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

