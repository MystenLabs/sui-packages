module 0xa5f3fa705c937380460289ce6244733597406aabe35ceab253c4e30fc48a1e96::tao {
    struct TAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAO>(arg0, 6, b"TAO", b"TAOONSUI", b"The First Meme Operating System on SUI. Website:https://www.taoonsui.pro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bdogbg_b44950adbe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

