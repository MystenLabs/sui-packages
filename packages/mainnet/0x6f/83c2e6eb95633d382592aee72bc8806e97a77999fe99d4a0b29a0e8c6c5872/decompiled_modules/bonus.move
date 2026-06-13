module 0x6f83c2e6eb95633d382592aee72bc8806e97a77999fe99d4a0b29a0e8c6c5872::bonus {
    struct BONUS has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BONUS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BONUS>>(0x2::coin::mint<BONUS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BONUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONUS>(arg0, 0, b"Bonus", b"SuiBonus.com - Visit to claim", b"Claim your Sui bonus at SuiBonus.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://placehold.co/240x240/4da2ff/ffffff/png?text=Bonus")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

