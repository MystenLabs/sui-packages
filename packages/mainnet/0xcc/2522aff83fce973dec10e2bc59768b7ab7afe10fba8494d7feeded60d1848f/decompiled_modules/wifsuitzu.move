module 0xcc2522aff83fce973dec10e2bc59768b7ab7afe10fba8494d7feeded60d1848f::wifsuitzu {
    struct WIFSUITZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFSUITZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFSUITZU>(arg0, 6, b"WifSuitzu", b"Shi Tzu Wif Hat", b"Shih Tzu Wif Hat $Suitzu is here to take on the world with smiles and cuteness! His name is Suitzu, the first and only Shih Tzu on Sui chain and he comes Wif Hat. Let him take you on a journey you wont forget!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sin_t_A_tulasd123123o_1_42317d3d38.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFSUITZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFSUITZU>>(v1);
    }

    // decompiled from Move bytecode v6
}

