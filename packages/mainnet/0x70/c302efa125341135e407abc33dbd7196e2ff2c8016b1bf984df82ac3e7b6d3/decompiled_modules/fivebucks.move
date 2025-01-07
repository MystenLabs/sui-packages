module 0x70c302efa125341135e407abc33dbd7196e2ff2c8016b1bf984df82ac3e7b6d3::fivebucks {
    struct FIVEBUCKS has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FIVEBUCKS>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FIVEBUCKS>>(0x2::coin::mint<FIVEBUCKS>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: FIVEBUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIVEBUCKS>(arg0, 9, b"FIVEB", b"FIVEBUCKS", b"Are we ready to celebrate FIVEBUCKS sui?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1752495158044626945/HusvsHSe_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FIVEBUCKS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIVEBUCKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIVEBUCKS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

