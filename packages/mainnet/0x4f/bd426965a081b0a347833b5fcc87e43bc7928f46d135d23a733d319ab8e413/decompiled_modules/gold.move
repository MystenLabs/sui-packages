module 0x4fbd426965a081b0a347833b5fcc87e43bc7928f46d135d23a733d319ab8e413::gold {
    struct GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLD>(arg0, 9, b"GOLD", b"GOLD", b"Gold is gold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co.com/RzHqkcx/images-9-2-1-jpeg-removebg-preview.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOLD>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

