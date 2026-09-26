module 0x9a7d3c1902ce97cbe3b5a11fc938fccd74e5a5d5a9624db50a3dcabe5daa8fb7::pplus {
    struct PPLUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPLUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPLUS>(arg0, 9, b"PPLUS", b"Bitwise Premium+", b"This receipt token represents the shares a user has of the Bitwise Premium+ Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.bluefin.io/images/PPLUS.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPLUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PPLUS>>(0x2::coin::mint<PPLUS>(&mut v2, 5000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PPLUS>>(v2);
    }

    // decompiled from Move bytecode v6
}

