module 0xe6a7aab8baf2722e1281ff472bf72537b17a48fa7d61eed4b77d076e38216731::hol {
    struct HOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOL>(arg0, 6, b"HOL", b"HOLDER SUI", b"IF U HOLD THIS TOKEN YOU WILL RECEIVE MORE TOKENS TO INCENTIVE ECOSSITEM OF SUI BLOCKCHAIM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ABYSS_25ea9c7369.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

