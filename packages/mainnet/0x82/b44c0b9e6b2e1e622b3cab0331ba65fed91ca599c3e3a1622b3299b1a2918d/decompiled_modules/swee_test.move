module 0x82b44c0b9e6b2e1e622b3cab0331ba65fed91ca599c3e3a1622b3299b1a2918d::swee_test {
    struct SWEE_TEST has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SWEE_TEST>, arg1: 0x2::coin::Coin<SWEE_TEST>) {
        0x2::coin::burn<SWEE_TEST>(arg0, arg1);
    }

    fun init(arg0: SWEE_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEE_TEST>(arg0, 6, b"SWEE_TEST", b"SWEE_TEST USDT Coin", b"SWEE_TEST USDT by Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pntvpw2m7uxvx7j4roojxy3sb2lrc57jqzwo66kafwdjaj5v3oea.arweave.net/e2dX20z9L1v9PIucm-NyDpcRd-mGbO95QC2GkCe124g")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWEE_TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWEE_TEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SWEE_TEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SWEE_TEST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

