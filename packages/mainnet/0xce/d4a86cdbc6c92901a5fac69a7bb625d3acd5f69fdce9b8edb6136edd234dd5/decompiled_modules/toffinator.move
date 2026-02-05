module 0xced4a86cdbc6c92901a5fac69a7bb625d3acd5f69fdce9b8edb6136edd234dd5::toffinator {
    struct TOFFINATOR has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOFFINATOR>, arg1: 0x2::coin::Coin<TOFFINATOR>) {
        0x2::coin::burn<TOFFINATOR>(arg0, arg1);
    }

    fun init(arg0: TOFFINATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOFFINATOR>(arg0, 6, b"Toffinator", b"Toffinator", b"Toffinator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1950648726726295552/vRs_CfxG_normal.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOFFINATOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOFFINATOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOFFINATOR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOFFINATOR>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

