module 0xe7429fd3564b23cfa819295dc9859783e2b7ed14cce71bc58cf91ae48a7be83f::lfg {
    struct LFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LFG>(arg0, 6, b"LFG", b"Lets go by SuiAI", b"Let's Fucking Go", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_06_19_07_13_A_playful_illustration_of_a_cute_cat_sitting_with_the_SUI_logo_incorporated_creatively_into_its_design_such_as_the_logo_appearing_as_a_medallion_on_t_f60feefefe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LFG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

