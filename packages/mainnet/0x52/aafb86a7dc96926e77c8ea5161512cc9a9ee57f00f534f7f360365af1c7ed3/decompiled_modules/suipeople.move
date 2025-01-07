module 0x52aafb86a7dc96926e77c8ea5161512cc9a9ee57f00f534f7f360365af1c7ed3::suipeople {
    struct SUIPEOPLE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIPEOPLE>, arg1: 0x2::coin::Coin<SUIPEOPLE>) {
        0x2::coin::burn<SUIPEOPLE>(arg0, arg1);
    }

    fun init(arg0: SUIPEOPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEOPLE>(arg0, 2, b"SUIPEOPLE", b"SUIPEOPLE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arbpeople.ai/images/token_arbpeople.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPEOPLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEOPLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPEOPLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIPEOPLE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

