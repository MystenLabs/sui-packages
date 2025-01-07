module 0x29246cf6d3e40c061e9bc3e57adab7518246b3087ac1837484b5b98adbd7d504::g10000000 {
    struct G10000000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: G10000000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<G10000000>(arg0, 9, b"G10000000", b"Goopi", b"The best in web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca36533f-de51-4ed3-92e5-ebeb35968edc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G10000000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<G10000000>>(v1);
    }

    // decompiled from Move bytecode v6
}

