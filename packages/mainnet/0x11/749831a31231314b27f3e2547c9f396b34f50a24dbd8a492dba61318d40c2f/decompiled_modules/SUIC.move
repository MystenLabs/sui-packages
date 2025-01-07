module 0x11749831a31231314b27f3e2547c9f396b34f50a24dbd8a492dba61318d40c2f::SUIC {
    struct SUIC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIC>, arg1: 0x2::coin::Coin<SUIC>) {
        0x2::coin::burn<SUIC>(arg0, arg1);
    }

    fun init(arg0: SUIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIC>(arg0, 9, b"SUIC", b"SUICIDE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/axQBBkZ?r")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

