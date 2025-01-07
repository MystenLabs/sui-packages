module 0x3619d3795ee1fc6e346add51ffc45539cc8cfc452527890b3deae5544ab32762::CATWG {
    struct CATWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATWG>(arg0, 9, b"CATWG", b"CAT WIF GUN", b"CATWG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lirp.cdn-website.com/fcb3f602/dms3rep/multi/opt/xxx-1920w.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATWG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CATWG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CATWG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

