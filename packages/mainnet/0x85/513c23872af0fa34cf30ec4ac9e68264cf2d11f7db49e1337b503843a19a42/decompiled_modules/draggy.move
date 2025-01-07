module 0x85513c23872af0fa34cf30ec4ac9e68264cf2d11f7db49e1337b503843a19a42::draggy {
    struct DRAGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGGY>(arg0, 6, b"DRAGGY", b"DRAGGY Sui", b"Draggy Sui. Dexscreener paid: Done ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_3_e5756575e5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

