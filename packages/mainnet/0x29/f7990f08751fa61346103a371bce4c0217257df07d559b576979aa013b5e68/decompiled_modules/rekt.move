module 0x29f7990f08751fa61346103a371bce4c0217257df07d559b576979aa013b5e68::rekt {
    struct REKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: REKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REKT>(arg0, 6, b"REKT", b"Don't Sell: $REKT", b"Dont Sell: Rektpaper", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dontselll_6547f3c124.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

