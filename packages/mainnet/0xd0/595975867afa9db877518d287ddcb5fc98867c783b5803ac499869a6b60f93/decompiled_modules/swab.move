module 0xd0595975867afa9db877518d287ddcb5fc98867c783b5803ac499869a6b60f93::swab {
    struct SWAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWAB>(arg0, 6, b"SWAB", b"Water Balloon", x"54686520666972737420616e64206f6e6c792057415445522042414c4c4f4f4e202070726f6a656374206f6e205355490a0a4445562057414c4c45542057494c4c20424520444f58584544200a44455820504149442041542034306b200a3130302070657263656e74207472616e73706172656e637920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7371_7cf1de74e2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

