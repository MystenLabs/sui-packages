module 0x8cc802aa246b2e00f8816f2cfac95894f30141505694cc57ae14da02348a9d92::dogeshit {
    struct DOGESHIT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGESHIT>, arg1: 0x2::coin::Coin<DOGESHIT>) {
        0x2::coin::burn<DOGESHIT>(arg0, arg1);
    }

    fun init(arg0: DOGESHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGESHIT>(arg0, 2, b"DOGESHIT", b"DOGESHIT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://dogeshit.org/images/arbswap-mobile.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGESHIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGESHIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGESHIT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGESHIT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

