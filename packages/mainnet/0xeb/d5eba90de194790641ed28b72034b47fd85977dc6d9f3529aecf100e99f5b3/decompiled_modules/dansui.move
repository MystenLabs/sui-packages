module 0xebd5eba90de194790641ed28b72034b47fd85977dc6d9f3529aecf100e99f5b3::dansui {
    struct DANSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANSUI>(arg0, 6, b"DANSUI", b"SUIDSUI", b"Lt dan retired from sui trenches, and so must our holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_204758456_b6cc910f20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

