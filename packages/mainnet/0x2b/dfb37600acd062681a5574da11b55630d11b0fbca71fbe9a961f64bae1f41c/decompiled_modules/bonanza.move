module 0x2bdfb37600acd062681a5574da11b55630d11b0fbca71fbe9a961f64bae1f41c::bonanza {
    struct BONANZA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BONANZA>, arg1: 0x2::coin::Coin<BONANZA>) {
        0x2::coin::burn<BONANZA>(arg0, arg1);
    }

    fun init(arg0: BONANZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONANZA>(arg0, 6, b"BONANZA", b"Bonanza Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/ww6BDnK/bonanza.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONANZA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONANZA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BONANZA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BONANZA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

