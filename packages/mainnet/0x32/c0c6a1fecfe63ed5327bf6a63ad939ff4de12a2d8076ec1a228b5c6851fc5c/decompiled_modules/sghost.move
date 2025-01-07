module 0x32c0c6a1fecfe63ed5327bf6a63ad939ff4de12a2d8076ec1a228b5c6851fc5c::sghost {
    struct SGHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGHOST>(arg0, 6, b"SGHOST", b"Sui Ghost", b"It not just ghost", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6929_e645eb6bc7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGHOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGHOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

