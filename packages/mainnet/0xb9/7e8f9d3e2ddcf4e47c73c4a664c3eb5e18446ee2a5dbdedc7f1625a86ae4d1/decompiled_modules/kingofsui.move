module 0xb97e8f9d3e2ddcf4e47c73c4a664c3eb5e18446ee2a5dbdedc7f1625a86ae4d1::kingofsui {
    struct KINGOFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGOFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGOFSUI>(arg0, 6, b"KINGOFSUI", b"KING KONG SUI", b"THE KING OF SUI ARRIVED AT MP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_13_011144023_cb2ff5f860.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGOFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGOFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

