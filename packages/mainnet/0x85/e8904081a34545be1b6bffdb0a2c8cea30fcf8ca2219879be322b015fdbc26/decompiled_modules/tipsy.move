module 0x85e8904081a34545be1b6bffdb0a2c8cea30fcf8ca2219879be322b015fdbc26::tipsy {
    struct TIPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIPSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIPSY>(arg0, 6, b"TIPSY", b"Tipsy on Sui", b"Boozing my sorrows in the oceans deep, a narwhal adrift in sorrows keep!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tripsy_07fb5a1c53.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIPSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIPSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

