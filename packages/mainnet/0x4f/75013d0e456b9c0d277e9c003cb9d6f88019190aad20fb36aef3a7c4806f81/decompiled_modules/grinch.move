module 0x4f75013d0e456b9c0d277e9c003cb9d6f88019190aad20fb36aef3a7c4806f81::grinch {
    struct GRINCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRINCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRINCH>(arg0, 6, b"GRINCH", x"4752c4b04e434820544f4b454e", x"46c4b0525354204752c4b04e434820544f4b454e204f4e205355c4b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732833140621.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRINCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRINCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

