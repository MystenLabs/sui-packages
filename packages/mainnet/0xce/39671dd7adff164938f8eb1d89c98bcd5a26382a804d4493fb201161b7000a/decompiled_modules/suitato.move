module 0xce39671dd7adff164938f8eb1d89c98bcd5a26382a804d4493fb201161b7000a::suitato {
    struct SUITATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITATO>(arg0, 6, b"Suitato", b"Sui Potato", b"Suitato is here to grow your bags faster than a potato in the dirt!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_42_54230a7e55.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

