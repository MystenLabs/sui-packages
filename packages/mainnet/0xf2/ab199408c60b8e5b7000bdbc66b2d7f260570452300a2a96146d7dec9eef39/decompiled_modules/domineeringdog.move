module 0xf2ab199408c60b8e5b7000bdbc66b2d7f260570452300a2a96146d7dec9eef39::domineeringdog {
    struct DOMINEERINGDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOMINEERINGDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOMINEERINGDOG>(arg0, 6, b"Domineeringdog", b"DEDOG", b"The coolest dog in the whole world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_ae_1707383421657_c57c44b13f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOMINEERINGDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOMINEERINGDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

