module 0x2ec35c8f7d5a37f5bdedf5cc1efbf74aab7f980d40fa90ade12ed30965abfbaf::beker {
    struct BEKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEKER>(arg0, 6, b"BEKER", b"BAKERY CAT", x"49204a5553542057414e5420544f2042414b4520414e4420504554204d5920434154530a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_Tela_2024_10_15_a_I_s_19_37_18_1a203efd1a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

