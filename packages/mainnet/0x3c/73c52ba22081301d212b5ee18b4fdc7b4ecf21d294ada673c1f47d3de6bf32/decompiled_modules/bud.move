module 0x3c73c52ba22081301d212b5ee18b4fdc7b4ecf21d294ada673c1f47d3de6bf32::bud {
    struct BUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUD>(arg0, 6, b"BUD", b"BIGBUD SUI", b"BIGBUD is the silent mastermind behind the Boys' Club's supply chain, providing the finest product to the crew.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_88_53e01a13b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

