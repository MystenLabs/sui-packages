module 0x4a72101f9764a680495352793983469dec756fb414a00ade758a279089b94306::tralalero {
    struct TRALALERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRALALERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRALALERO>(arg0, 6, b"TRALALERO", b"Tralalero On Sui", b"Tralero Tralala is the OG & Most Iconic Italian Rot Character!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tralalero_perfil_40ce84fc30.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRALALERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRALALERO>>(v1);
    }

    // decompiled from Move bytecode v6
}

