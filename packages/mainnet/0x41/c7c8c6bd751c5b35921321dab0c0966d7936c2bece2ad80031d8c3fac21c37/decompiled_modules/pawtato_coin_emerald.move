module 0x41c7c8c6bd751c5b35921321dab0c0966d7936c2bece2ad80031d8c3fac21c37::pawtato_coin_emerald {
    struct PAWTATO_COIN_EMERALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_EMERALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_EMERALD>(arg0, 9, b"EMERALD", b"Pawtato Emerald", b"A properly cut and polished Emerald, offering clear color and radiance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/emerald.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_EMERALD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_EMERALD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_emerald(arg0: 0x2::coin::Coin<PAWTATO_COIN_EMERALD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_EMERALD>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

