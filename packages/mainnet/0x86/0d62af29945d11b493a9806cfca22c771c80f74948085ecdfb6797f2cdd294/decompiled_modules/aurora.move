module 0x860d62af29945d11b493a9806cfca22c771c80f74948085ecdfb6797f2cdd294::aurora {
    struct AURORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURORA>(arg0, 6, b"AURORA", b"Operation AURORA", b"Trumps Operation Aurora", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/june_21st_2023_portrait_donald_260nw_2320981303_ezgif_com_webp_to_jpg_converter_2354a3b35b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AURORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

