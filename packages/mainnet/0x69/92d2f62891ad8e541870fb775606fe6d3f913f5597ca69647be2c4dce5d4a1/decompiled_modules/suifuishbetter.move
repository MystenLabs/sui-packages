module 0x6992d2f62891ad8e541870fb775606fe6d3f913f5597ca69647be2c4dce5d4a1::suifuishbetter {
    struct SUIFUISHBETTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUISHBETTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFUISHBETTER>(arg0, 6, b"SUIFUISHbetter", b"SUI FUISH", b"Just a fish in the Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_N_D_D_D_D_216041a34e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFUISHBETTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFUISHBETTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

