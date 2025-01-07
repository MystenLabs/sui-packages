module 0x6d114b6c7b61535499d365c1ab407fa702a91129aa06b3463b659954e529f42f::manatee {
    struct MANATEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANATEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANATEE>(arg0, 6, b"Manatee", b"Manatee Sui", b"$Manatee aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_38_086ee77bce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANATEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANATEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

