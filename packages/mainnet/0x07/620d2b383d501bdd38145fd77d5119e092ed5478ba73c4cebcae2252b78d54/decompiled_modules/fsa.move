module 0x7620d2b383d501bdd38145fd77d5119e092ed5478ba73c4cebcae2252b78d54::fsa {
    struct FSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSA>(arg0, 9, b"FSA", b"GSW", b"FDSAF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/defacd3b-ffa5-47ac-a2e1-fd01d46bf509.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

