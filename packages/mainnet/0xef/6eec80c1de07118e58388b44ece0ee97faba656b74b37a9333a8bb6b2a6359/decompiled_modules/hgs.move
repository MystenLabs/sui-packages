module 0xef6eec80c1de07118e58388b44ece0ee97faba656b74b37a9333a8bb6b2a6359::hgs {
    struct HGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HGS>(arg0, 6, b"HGS", b"HEDGESUI", b"Hello, future meme creators! Together, build a vibrant meme community on Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_b03eb2ddfb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

