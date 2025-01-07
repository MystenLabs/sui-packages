module 0x61d63c2ba1bbfcdd93ef23d407290184a6e8b06373a466085badf1a9a4bbd17a::castle {
    struct CASTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASTLE>(arg0, 6, b"CASTLE", b"Castle of Sui", b"$CASTLE stands tall in the Sui Network, fortified and strong. The grand fortress that guards its riches with an iron will. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_30_ed6621f54b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASTLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

