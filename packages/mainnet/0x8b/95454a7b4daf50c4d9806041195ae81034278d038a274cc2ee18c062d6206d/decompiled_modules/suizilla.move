module 0x8b95454a7b4daf50c4d9806041195ae81034278d038a274cc2ee18c062d6206d::suizilla {
    struct SUIZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZILLA>(arg0, 6, b"SUIZILLA", b"Suizilla On Sui", b"https://x.com/SuiZillaX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c3p_W_Rc7w_400x400_8da8735450.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

