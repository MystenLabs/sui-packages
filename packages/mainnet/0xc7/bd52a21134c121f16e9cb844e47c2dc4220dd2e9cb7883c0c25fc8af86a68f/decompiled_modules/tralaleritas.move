module 0xc7bd52a21134c121f16e9cb844e47c2dc4220dd2e9cb7883c0c25fc8af86a68f::tralaleritas {
    struct TRALALERITAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRALALERITAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRALALERITAS>(arg0, 6, b"Tralaleritas", b"Tralaleritas Tralalerotralala", b"#tralaleritas #tralalerotralala", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sin_t_A_tulo_c3e6a480c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRALALERITAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRALALERITAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

