module 0x84f388a9a200911ad378abb514a36c50a6c40506949c0d45a2ee476f0bd09d84::shui {
    struct SHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUI>(arg0, 6, b"SHUI", b"Shui Quan", b"The first Chinese Water dog on SUI Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/xH1sEC5.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

