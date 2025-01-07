module 0x16b19089a04ad862f66bc9e0855c5b56c18ad2a1f34c53ca57815a0d2da211b1::quack {
    struct QUACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUACK>(arg0, 6, b"QUACK", b"Ugly Duck", b"QUACK!QUACK!QUACK! Enjoy our Quack game on the website!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ppp_bf1f948547.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

