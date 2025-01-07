module 0x9365c8a14f64c274c285b682e87ad86ca146fa3c796d907c4c24129b25ea5802::diddy {
    struct DIDDY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DIDDY>, arg1: 0x2::coin::Coin<DIDDY>) {
        0x2::coin::burn<DIDDY>(arg0, arg1);
    }

    fun init(arg0: DIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDY>(arg0, 9, b"DIDDY", b"DIDDY baby oil", b"DIDDY baby oil", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfBC7N75Kg1wcMJX9QcDmhhxgTWQDunoNbGTeaRBgwk7f")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DIDDY>(&mut v2, 6000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIDDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

