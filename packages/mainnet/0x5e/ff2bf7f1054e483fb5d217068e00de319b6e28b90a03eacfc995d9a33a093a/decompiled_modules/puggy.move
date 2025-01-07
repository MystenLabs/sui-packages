module 0x5eff2bf7f1054e483fb5d217068e00de319b6e28b90a03eacfc995d9a33a093a::puggy {
    struct PUGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGGY>(arg0, 6, b"PUGGY", b"SuiPuggy", b"SuiPoggy: The cutest and most playful token on Sui blockchain! Powered by memes, fueled by fun, and built for the community. Join the Poggy gang and let's make the moon our playground!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732173425495.49")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUGGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGGY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

