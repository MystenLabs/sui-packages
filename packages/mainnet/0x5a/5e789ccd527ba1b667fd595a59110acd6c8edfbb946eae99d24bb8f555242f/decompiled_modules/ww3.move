module 0x5a5e789ccd527ba1b667fd595a59110acd6c8edfbb946eae99d24bb8f555242f::ww3 {
    struct WW3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WW3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WW3>(arg0, 6, b"WW3", b"Worldwar on Sui", b"Join up and be a part of the new world order.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo1_47fbc858b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WW3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WW3>>(v1);
    }

    // decompiled from Move bytecode v6
}

