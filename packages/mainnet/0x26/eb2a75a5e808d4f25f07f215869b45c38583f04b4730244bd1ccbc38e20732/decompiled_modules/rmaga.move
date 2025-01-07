module 0x26eb2a75a5e808d4f25f07f215869b45c38583f04b4730244bd1ccbc38e20732::rmaga {
    struct RMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMAGA>(arg0, 6, b"RMAGA", b"RED MAGA", b"RedMaga is a symbol of a new era. Supporting the idea of greatness and leadership, RedMaga unites those who stand for global change and freedom. This is more than just a token  its a voice for the future, where innovation and progress come together with traditional values.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_D_D_82228311dc.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

