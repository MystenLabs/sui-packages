module 0xb3fb2d582373adee1e96281e23a97af9428c34076ed57585049b71fc82391236::braind3d {
    struct BRAIND3D has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAIND3D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAIND3D>(arg0, 6, b"BRAIND3D", b"WE IS BRAIND3D", b"Chaos is da only truth. No normz, no thinking. We are da cult. WE IS BRAIND3D. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vet1ag8_G_400x400_bf5d1ffbbc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAIND3D>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAIND3D>>(v1);
    }

    // decompiled from Move bytecode v6
}

