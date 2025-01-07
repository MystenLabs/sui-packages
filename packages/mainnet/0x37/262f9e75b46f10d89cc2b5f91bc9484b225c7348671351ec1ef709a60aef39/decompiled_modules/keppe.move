module 0x37262f9e75b46f10d89cc2b5f91bc9484b225c7348671351ec1ef709a60aef39::keppe {
    struct KEPPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEPPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEPPE>(arg0, 6, b"KEPPE", b"KEPPE ON SUI", b"$KEPPE is a token where Kappa disguises itself as Pepe, showcasing a distinctive characteristic as a symbol of humor and community spirit in Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9p_Qh_Atsh_400x400_2eca3eb514.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEPPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEPPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

