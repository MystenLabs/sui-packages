module 0xab80d8487a8312987a6d29653a0a074acdf61f9009c27d520c6318708fcdc201::neverrug {
    struct NEVERRUG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NEVERRUG>, arg1: 0x2::coin::Coin<NEVERRUG>) {
        0x2::coin::burn<NEVERRUG>(arg0, arg1);
    }

    fun init(arg0: NEVERRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEVERRUG>(arg0, 6, b"NEVERRUG", b"Never Rug Token", b"This token is created to be 100% profit investment, say no to rug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEVERRUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEVERRUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NEVERRUG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NEVERRUG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

