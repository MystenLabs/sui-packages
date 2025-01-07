module 0x45c12aafb748ef2cf889446705d0c73037e6f0a4ce3d1e52327aa0b44fb9d24::fonky {
    struct FONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FONKY>(arg0, 6, b"Fonky", b"Funny Monkey", x"466f6e6b65790a46756e6e69656e7374204d6f6e6b6579206f6e20535549204e4554574f524b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20240925_225559_Gallery_9d7166ad9f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FONKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FONKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

