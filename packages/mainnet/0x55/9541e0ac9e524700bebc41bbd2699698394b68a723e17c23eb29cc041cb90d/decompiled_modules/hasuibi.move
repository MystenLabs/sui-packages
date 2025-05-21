module 0x559541e0ac9e524700bebc41bbd2699698394b68a723e17c23eb29cc041cb90d::hasuibi {
    struct HASUIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASUIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASUIBI>(arg0, 6, b"HASUIBI", b"Sui Habibi", b"HABIBI, THIS AIN'T JUST A COIN, IT'S A LIFESTYLE WELCOME TO SUI HABIBI! YALLA YALLA!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreian6drrqytgdqtumhnzay4e32pzjvnmeahwar22jdx7kak6akqwqu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASUIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HASUIBI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

