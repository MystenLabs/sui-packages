module 0x6b3c51f7a4bea51ff54691089fbb63172df2d6bcf6e257c418087508e3d4d3fa::nep {
    struct NEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEP>(arg0, 6, b"NEP", b"NEPTUNUS", b"NEPTUNUS AI smart trade bot on telegram", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731947465550.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

