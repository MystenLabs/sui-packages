module 0x89cbd8078543231735b5a4f77ad6031bcd9bd95da2ed36814bd7cb4f0a420076::host {
    struct HOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOST>(arg0, 6, b"HOST", b"HOST Sui", b"join the movement host new ultimate memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ezgif_com_gif_maker_3_10dc3b4995.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

