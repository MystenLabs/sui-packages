module 0x2040e1448e685fd9386dbbddf1aae9e23dc3a0164db57bf813f950c90e1ef53::movex {
    struct MOVEX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOVEX>, arg1: 0x2::coin::Coin<MOVEX>) {
        0x2::coin::burn<MOVEX>(arg0, arg1);
    }

    fun init(arg0: MOVEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEX>(arg0, 8, b"MOV", b"MovEx", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movex.exchange/icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOVEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEX>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOVEX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOVEX>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

