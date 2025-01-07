module 0x415b3ed86c95d483e4a20492893b468fcb6b9cc462fc66e4381413b348455f21::robocat {
    struct ROBOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOCAT>(arg0, 9, b"ROBOCAT", b"ROBO", b"Wake up ROBO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50f78ded-2254-420b-83d1-ac5c6179c46c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROBOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

