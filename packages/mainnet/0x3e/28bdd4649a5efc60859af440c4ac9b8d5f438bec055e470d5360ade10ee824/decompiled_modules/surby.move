module 0x3e28bdd4649a5efc60859af440c4ac9b8d5f438bec055e470d5360ade10ee824::surby {
    struct SURBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURBY>(arg0, 6, b"Surby", b"Surby on Sui", b"The most memeable meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SURBY_PROFILE_7f43df1827.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

