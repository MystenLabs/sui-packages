module 0x1cc3525e82d84b60625af9147cb4c95cac63e2eded738e490450031d9d230259::ols {
    struct OLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLS>(arg0, 6, b"OLS", b"Oliyos", b"Oliyos Coin (OLS) is a project of great interest within the SUI blockchain ecosystem, aimed at promoting a currency that can be used for purchases on Oliyos.com. The platform focuses on renewable energy products, such as solar power banks and UV self-sterilizingwaterbottles.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Oliyos_Coin_758d21db96.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

