module 0xe3e0bfe9954c5eda781e082e71d5458883775cbdf882f0cdb38a7d269b980023::wr {
    struct WR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WR>(arg0, 6, b"Wr", b"WE ROBOT", b"We robot ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7132_bd02278f07.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WR>>(v1);
    }

    // decompiled from Move bytecode v6
}

