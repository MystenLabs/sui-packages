module 0x1810ef6d1b38787e44ad50b254e2e022eea353ac578c63e3aaeff94504e72ca4::drlee {
    struct DRLEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRLEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRLEE>(arg0, 6, b"DRLEE", b"Dr Harrison Lee", b"The guy who turned Bruce to Caitlyn. Some call me god, some call me DRLEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Tela_2024_10_14_a_I_s_12_12_07_f9955e1e76.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRLEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRLEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

