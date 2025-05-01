module 0x3009827e96a08d3a6a3f52fcd43099a10484f583321f9aadf88465b950f76f7::suiray {
    struct SUIRAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRAY>(arg0, 6, b"SUIRAY", b"Ray", b"Ray to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1918_12ae9b1ed5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

