module 0x6e82bb8cbed21683ac0109171135b4d75187fc74749593163f3dc426ef3b32b4::pawtato_coin_phoenix_feather {
    struct PAWTATO_COIN_PHOENIX_FEATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_PHOENIX_FEATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_PHOENIX_FEATHER>(arg0, 9, b"PHOENIX_FEATHER", b"Pawtato Phoenix Feather", b"Sacred feathers from the legendary phoenix, imbued with fire magic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/phoenix-feather.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_PHOENIX_FEATHER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_PHOENIX_FEATHER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_phoenix_feather(arg0: 0x2::coin::Coin<PAWTATO_COIN_PHOENIX_FEATHER>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_PHOENIX_FEATHER>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

