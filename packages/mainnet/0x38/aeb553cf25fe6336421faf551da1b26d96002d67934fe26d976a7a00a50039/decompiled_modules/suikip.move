module 0x38aeb553cf25fe6336421faf551da1b26d96002d67934fe26d976a7a00a50039::suikip {
    struct SUIKIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKIP>(arg0, 6, b"Suikip", b"Mudsuikip", b"Another pokemon meme on su network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9700_3a52d3e335.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

