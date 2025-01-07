module 0xcc5296ae01906bec87eeb6180de96a464a34514aaeadd91deda3169bbc921350::wed {
    struct WED has drop {
        dummy_field: bool,
    }

    fun init(arg0: WED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WED>(arg0, 6, b"Wed", b"ffw", b"dd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0697_3eac01ad2f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WED>>(v1);
    }

    // decompiled from Move bytecode v6
}

