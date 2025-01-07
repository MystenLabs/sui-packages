module 0x7356d54e755c4101e94d3e856356b28c5f8a0f952c1616e669bd044073a768e9::suipider {
    struct SUIPIDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIDER>(arg0, 6, b"SUIPIDER", b"Sui Spider", b"Creepy, crawly, and webbing through the Sui Network, $SUIPIDER is always lurking around. Watch out, or you might get tangled in its web! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_rpg_item_icon_of_a_blue_spiderconcept_artart_gamecre_98aeacbd_bbce_465f_b96e_c180347735ca_2_e9fb470d50.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPIDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

