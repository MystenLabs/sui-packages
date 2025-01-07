module 0xc80181f7245fd03744509897fe77d4e722a4dfc37d23c5e4ef0a33377cd8e9f7::mgc {
    struct MGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGC>(arg0, 6, b"MGC", b"magic2", b"Magic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_11_16_173230_a8560a77ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

