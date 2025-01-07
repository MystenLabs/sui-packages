module 0xb744ea9fefe449c0d706c40e986a8a1e715394eec5b44962e431b08211019547::swee_cap {
    struct SWEE_CAP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SWEE_CAP>, arg1: 0x2::coin::Coin<SWEE_CAP>) {
        0x2::coin::burn<SWEE_CAP>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SWEE_CAP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SWEE_CAP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SWEE_CAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEE_CAP>(arg0, 6, b"SWEE_CAP", b"SWEE_CAP USDT Coin", b"SWEE_CAP USDT by Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pntvpw2m7uxvx7j4roojxy3sb2lrc57jqzwo66kafwdjaj5v3oea.arweave.net/e2dX20z9L1v9PIucm-NyDpcRd-mGbO95QC2GkCe124g")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWEE_CAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SWEE_CAP>>(0x2::coin::mint<SWEE_CAP>(&mut v2, 10000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SWEE_CAP>>(v2);
    }

    // decompiled from Move bytecode v6
}

