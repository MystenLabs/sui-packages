module 0x888954e2f636c376949cd4f5eed21effcf3cb104b55159d55c0705a71075b601::drip {
    struct DRIP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DRIP>, arg1: 0x2::coin::Coin<DRIP>) {
        0x2::coin::burn<DRIP>(arg0, arg1);
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<DRIP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DRIP>(arg0, 1000000000000000000, arg2, arg3);
    }

    fun init(arg0: DRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIP>(arg0, 6, b"DRIP", b"Drip", b"Sui got Drip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/Ghvl7ZY.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

