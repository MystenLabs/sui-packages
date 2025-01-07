module 0x910de5fbab00fdf431bbcc08628f4ce6f4c61b85a94555c026889e319ec57f9e::sumuuh {
    struct SUMUUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMUUH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMUUH>(arg0, 6, b"SUMUUH", b"SUMU THE BULL", b"SUMU THE BULL ARRIVED AT MOVEPUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_141934229_65c54e9ce1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMUUH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMUUH>>(v1);
    }

    // decompiled from Move bytecode v6
}

