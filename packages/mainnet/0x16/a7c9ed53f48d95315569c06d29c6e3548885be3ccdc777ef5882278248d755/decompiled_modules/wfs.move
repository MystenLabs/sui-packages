module 0x16a7c9ed53f48d95315569c06d29c6e3548885be3ccdc777ef5882278248d755::wfs {
    struct WFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WFS>(arg0, 6, b"WFS", b"WEASEL FLY SUI", x"57656c636f6d6520746f2074686520576f726c64206f662057656173656c20666c79210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_39_9e1f536a65.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

