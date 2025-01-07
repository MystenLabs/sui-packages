module 0x3c111beea60cd6e9912b6aa72de3b09297c45df5be3fe6b3e6f646b9626a3846::nyan {
    struct NYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYAN>(arg0, 6, b"NYAN", b"NYAN CAT", b"NYAN CAT OFFICIAL TWITTER! `.,,.*`.(=^^) #NyanCat | http://nyan.cat | NOT doing crypto coins | prguitarman1@gmail.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/64d10c6ddebe9b46e362e8bd_nyan_logo_orig_p_500_b2f82fa832.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

