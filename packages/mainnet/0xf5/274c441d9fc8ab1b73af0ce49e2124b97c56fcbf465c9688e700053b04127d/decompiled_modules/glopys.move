module 0xf5274c441d9fc8ab1b73af0ce49e2124b97c56fcbf465c9688e700053b04127d::glopys {
    struct GLOPYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOPYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOPYS>(arg0, 6, b"Glopys", b"Glopys - Sui Maskot", b"Glopys is a naughty Capy, whose upbringing even his parents cannot cope with. He didn't believe in miracles and constantly finds no childish adventures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fkqs_Xr_S_Xg_AM_Bx8_Y_c766584d0b.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOPYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOPYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

