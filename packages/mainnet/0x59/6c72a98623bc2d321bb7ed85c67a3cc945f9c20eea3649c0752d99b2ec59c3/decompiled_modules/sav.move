module 0x596c72a98623bc2d321bb7ed85c67a3cc945f9c20eea3649c0752d99b2ec59c3::sav {
    struct SAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAV>(arg0, 6, b"SAV", b"Savior", b"Buy the savior of crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Salvador_del_mundo_de_las_criptomonedas_con_el_logo_de_la_red_Sui_6bf9e77ad8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

