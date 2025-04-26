module 0x87ccc4e1664c5e75a58a4c3eb678caafa3fac7805423d5ff44d90bb5a8f8dae4::ols {
    struct OLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLS>(arg0, 6, b"OLS", b"Oliyos", b"Oliyos Coin (OLS) is a project of great interest within the SUI blockchain ecosystem, aimed at promoting a currency that can be used for purchases on Oliyos.com. The platform focuses on renewable energy products, such as solar power banks and UV self-sterilizing water bottles.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Oliyos_A_white_66e49cddc5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

