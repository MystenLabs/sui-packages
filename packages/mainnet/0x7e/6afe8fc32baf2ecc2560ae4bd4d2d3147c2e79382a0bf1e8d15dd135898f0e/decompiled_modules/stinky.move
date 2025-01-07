module 0x7e6afe8fc32baf2ecc2560ae4bd4d2d3147c2e79382a0bf1e8d15dd135898f0e::stinky {
    struct STINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STINKY>(arg0, 6, b"STINKY", b"SUISTINKY", b"Odor so strong, its legendary", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_18_17_52_c978cdd130.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

