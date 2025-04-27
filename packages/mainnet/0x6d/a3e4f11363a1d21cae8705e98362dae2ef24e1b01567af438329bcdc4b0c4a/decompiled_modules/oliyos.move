module 0x6da3e4f11363a1d21cae8705e98362dae2ef24e1b01567af438329bcdc4b0c4a::oliyos {
    struct OLIYOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLIYOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLIYOS>(arg0, 6, b"OLIYOS", b"Oliyos", b"Oliyos Coin (OLS) is a project of great interest within the SUI blockchain ecosystem, aimed at promoting a currency that can be used for purchases on Oliyos.com. The platform focuses on renewable energy products, such as solar power banks and UV self-sterilizing water bottles.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Oliyos_Coin_2b14d47f5e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLIYOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLIYOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

