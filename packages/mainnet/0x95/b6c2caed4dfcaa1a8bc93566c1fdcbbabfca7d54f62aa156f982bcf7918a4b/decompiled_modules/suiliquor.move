module 0x95b6c2caed4dfcaa1a8bc93566c1fdcbbabfca7d54f62aa156f982bcf7918a4b::suiliquor {
    struct SUILIQUOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILIQUOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILIQUOR>(arg0, 6, b"SuiLiquor", b"Liquor", b"Be liquor, my friend. New era of meme on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_H_E2_Fq_E_400x400_be1ce57fe4_0e081fcf45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILIQUOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILIQUOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

