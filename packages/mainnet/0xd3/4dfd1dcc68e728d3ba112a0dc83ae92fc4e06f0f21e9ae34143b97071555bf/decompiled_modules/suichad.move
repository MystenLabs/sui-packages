module 0xd34dfd1dcc68e728d3ba112a0dc83ae92fc4e06f0f21e9ae34143b97071555bf::suichad {
    struct SUICHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHAD>(arg0, 6, b"Suichad", b"Sui Chad", b"Real Chads use Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihl4mehv6jeh4lbyxjl5e55lnqamto5n35izyxviu7bgy4fefyahy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICHAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

