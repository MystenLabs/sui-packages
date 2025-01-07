module 0x931201db01dfb95cf7751f93ba7b71db90eb17a58a63ef576616486aeb3c5a68::diahands {
    struct DIAHANDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAHANDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAHANDS>(arg0, 6, b"DIAHANDS", x"f09f928ef09f998c", x"f09f928ef09f998c20484f444c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732419723532.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIAHANDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAHANDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

