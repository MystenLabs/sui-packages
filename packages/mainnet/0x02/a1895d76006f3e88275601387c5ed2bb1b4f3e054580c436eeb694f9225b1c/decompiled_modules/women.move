module 0x2a1895d76006f3e88275601387c5ed2bb1b4f3e054580c436eeb694f9225b1c::women {
    struct WOMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOMEN>(arg0, 6, b"WOMEN", b"SUIWOMEN", x"535549574f4d454e0a434f4d494e4720544f2053415645205448452043525950544f20574f524c44", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000198286_e911b54ad4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

