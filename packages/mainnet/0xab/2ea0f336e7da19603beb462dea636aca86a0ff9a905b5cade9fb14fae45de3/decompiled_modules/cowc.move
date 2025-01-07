module 0xab2ea0f336e7da19603beb462dea636aca86a0ff9a905b5cade9fb14fae45de3::cowc {
    struct COWC has drop {
        dummy_field: bool,
    }

    fun init(arg0: COWC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COWC>(arg0, 6, b"COWC", b"CowCoin on Sui", b"Jump into the corral and be part of Cow Coin today on Sui Network! The crypto future has a new sound: MOO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_d08111a60a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COWC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COWC>>(v1);
    }

    // decompiled from Move bytecode v6
}

