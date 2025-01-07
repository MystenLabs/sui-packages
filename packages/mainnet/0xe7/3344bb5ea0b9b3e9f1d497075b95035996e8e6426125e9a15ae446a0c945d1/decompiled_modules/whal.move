module 0xe73344bb5ea0b9b3e9f1d497075b95035996e8e6426125e9a15ae446a0c945d1::whal {
    struct WHAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHAL>(arg0, 6, b"Whal", b"Narwhal Moverz", b" We like to Move it ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kfn_Y_Qu_S2_400x400_1_c70ee89bf4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

