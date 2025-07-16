module 0x2d8bd9df53355ac2d2a4fabe4707aed46fc0d993c1a93331b538300bf18644bb::pawtato_coin_stone {
    struct PAWTATO_COIN_STONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_STONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_STONE>(arg0, 9, b"STONE", b"Pawtato Stone", b"Durable building material mined from Pawtato Lands.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/stone.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_STONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_STONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_stone(arg0: 0x2::coin::Coin<PAWTATO_COIN_STONE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_STONE>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

