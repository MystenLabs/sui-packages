module 0x99a998adce2c998cedc2696f24b8ab024582497118b86feeca8fbecaaf27b72d::suiblum {
    struct SUIBLUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBLUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBLUM>(arg0, 6, b"SUIBLUM", b"SUI BLUM", b"Your easy, fun crypto trading app for buying and trading any coin on the market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/29dcl6_FV_400x400_97f77ff08a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBLUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBLUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

