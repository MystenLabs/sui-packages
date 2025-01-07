module 0x76341d078efc571a37a304c2a26273a3cbb212ec12e25cb8af7991aa28d0982c::hutao {
    struct HUTAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUTAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUTAO>(arg0, 6, b"HUTAO", b"Lil Hu Tao", b"Who knew guiding spirits could be this fun?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_233800_c0dcc25d96.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUTAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUTAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

