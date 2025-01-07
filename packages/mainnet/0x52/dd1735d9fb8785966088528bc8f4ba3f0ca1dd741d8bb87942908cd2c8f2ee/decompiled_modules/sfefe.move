module 0x52dd1735d9fb8785966088528bc8f4ba3f0ca1dd741d8bb87942908cd2c8f2ee::sfefe {
    struct SFEFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFEFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFEFE>(arg0, 6, b"SFEFE", b"SUIFEFE", b"$SFEFE, the frog from Mindviscosity, by Matt Furie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6g_S9x_Wl_Y_400x400_8be34b4b0c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFEFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFEFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

