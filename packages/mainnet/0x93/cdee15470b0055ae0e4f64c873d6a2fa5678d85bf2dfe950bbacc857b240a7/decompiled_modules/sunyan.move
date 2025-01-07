module 0x93cdee15470b0055ae0e4f64c873d6a2fa5678d85bf2dfe950bbacc857b240a7::sunyan {
    struct SUNYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNYAN>(arg0, 6, b"SUNYAN", b"Su NYAN CAT", x"0a22506f7765726564206279205375692c20666c7920776974682053754e79616e2d207468652063757465737420636174206f6e20746865206e657720626c6f636b21220a44657374696e6174696f6e2031202442494c4c494f4e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logomain_91d2405e3b.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

