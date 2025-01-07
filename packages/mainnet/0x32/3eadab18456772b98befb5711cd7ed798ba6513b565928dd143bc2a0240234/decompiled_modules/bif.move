module 0x323eadab18456772b98befb5711cd7ed798ba6513b565928dd143bc2a0240234::bif {
    struct BIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIF>(arg0, 6, b"BIF", b"BillyWifHat", b"JUST A BILLY WIF HAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BIF_97e2b7cfe4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

