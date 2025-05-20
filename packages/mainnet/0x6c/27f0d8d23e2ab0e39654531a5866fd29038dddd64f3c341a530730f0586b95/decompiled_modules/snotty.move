module 0x6c27f0d8d23e2ab0e39654531a5866fd29038dddd64f3c341a530730f0586b95::snotty {
    struct SNOTTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOTTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOTTY>(arg0, 6, b"SNOTTY", b"Suisaurus", b"The one and only Suisaurus. All others are extinct. My name is Snotty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihwgfus7lxgls7qkbics4hcmsxdckgyppp4g2u3jxwdsyhhmmzupa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOTTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNOTTY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

