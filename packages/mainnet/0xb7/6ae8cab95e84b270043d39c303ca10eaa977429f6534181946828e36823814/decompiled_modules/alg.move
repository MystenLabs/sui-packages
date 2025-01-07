module 0xb76ae8cab95e84b270043d39c303ca10eaa977429f6534181946828e36823814::alg {
    struct ALG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALG>(arg0, 6, b"ALG", b"Ali G", b"Ali G on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ali_G_Sacha_Baron_Cohen_M_Mert_Erg_A_den_f53e2537b4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALG>>(v1);
    }

    // decompiled from Move bytecode v6
}

