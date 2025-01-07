module 0x4109e6474d7489a081c628827e720e68d768bd37e6ef3ad25e9911416c4381db::ractos {
    struct RACTOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACTOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACTOS>(arg0, 6, b"Ractos", b"Sui Ractos", b"Ractos memecoin - the electrifying raccoon on sui ready rock the market with his guitar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003069_c9a9a87412.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACTOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RACTOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

