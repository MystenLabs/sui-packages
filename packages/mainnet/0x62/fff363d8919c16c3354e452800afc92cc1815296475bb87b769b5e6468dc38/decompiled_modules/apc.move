module 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc {
    struct APC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<APC>, arg1: 0x2::coin::Coin<APC>) {
        0x2::coin::burn<APC>(arg0, arg1);
    }

    fun init(arg0: APC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APC>(arg0, 8, b"APC", b"APass Coin", b"Visit at https://sui.apass.network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://apass.network/eco/apc.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APC>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<APC>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<APC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<APC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

