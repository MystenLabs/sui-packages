module 0xcfa7c85d85b12bc8d2c088221b2b0031edd6b2f425c7ba9c2a721e6de949baf4::wifsui {
    struct WIFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFSUI>(arg0, 6, b"WIFSUI", b"DOGWIFSUI", b"The legendary memeable dog Achi. Joining Sui as DogWifSui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_07_09_21_4195c29bba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

