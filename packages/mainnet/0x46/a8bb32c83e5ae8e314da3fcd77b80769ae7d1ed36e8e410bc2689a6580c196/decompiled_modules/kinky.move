module 0x46a8bb32c83e5ae8e314da3fcd77b80769ae7d1ed36e8e410bc2689a6580c196::kinky {
    struct KINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINKY>(arg0, 6, b"KINKY", b"Kinky on Sui", b"Hey! Its me $KINKY, I'm coming on SUI chain and I'm the spokesperson of LGBTQ+ ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_Zpb_KW_9z_400x400_9582a6b247.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

