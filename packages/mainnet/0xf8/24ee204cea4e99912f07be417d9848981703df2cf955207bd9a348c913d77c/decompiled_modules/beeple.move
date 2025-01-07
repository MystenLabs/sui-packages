module 0xf824ee204cea4e99912f07be417d9848981703df2cf955207bd9a348c913d77c::beeple {
    struct BEEPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEPLE>(arg0, 6, b"BEEPLE", b"Beeple", b"Parody Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9512_cae4b4c2b8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEEPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

