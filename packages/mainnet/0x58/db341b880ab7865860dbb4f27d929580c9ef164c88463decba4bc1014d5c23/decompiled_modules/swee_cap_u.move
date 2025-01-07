module 0x58db341b880ab7865860dbb4f27d929580c9ef164c88463decba4bc1014d5c23::swee_cap_u {
    struct SWEE_CAP_U has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SWEE_CAP_U>, arg1: 0x2::coin::Coin<SWEE_CAP_U>) {
        0x2::coin::burn<SWEE_CAP_U>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SWEE_CAP_U>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SWEE_CAP_U>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SWEE_CAP_U, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEE_CAP_U>(arg0, 6, b"SWEE_CAP_U", b"SWEE_CAP_U USDT Coin", b"SWEE_CAP_U USDT by Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pntvpw2m7uxvx7j4roojxy3sb2lrc57jqzwo66kafwdjaj5v3oea.arweave.net/e2dX20z9L1v9PIucm-NyDpcRd-mGbO95QC2GkCe124g")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWEE_CAP_U>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SWEE_CAP_U>>(0x2::coin::mint<SWEE_CAP_U>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SWEE_CAP_U>>(v2);
    }

    // decompiled from Move bytecode v6
}

