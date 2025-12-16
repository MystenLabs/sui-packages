module 0x6ebcc2b4db93927ba9d9f93e1d0529076a3dbcffe58450eac756f0bc2b5ea64f::pawtato_coin_amethyst {
    struct PAWTATO_COIN_AMETHYST has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_AMETHYST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_AMETHYST>(arg0, 9, b"AMETHYST", b"Pawtato Amethyst", b"A properly cut and polished Amethyst, offering clear color and radiance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/amethyst.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_AMETHYST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_AMETHYST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_amethyst(arg0: 0x2::coin::Coin<PAWTATO_COIN_AMETHYST>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_AMETHYST>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

