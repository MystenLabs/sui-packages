module 0xb51ce1b1dd932d88afc894fbba6632c68e9dedb3afb3193b3a8bbcbcad6a18fc::wagmi {
    struct WAGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAGMI>(arg0, 6, b"WAGMI", b"STOP CHILL GO WORK", b"STOP CHILL GO TO WORK ON SUI : https://stopchillonsui.lol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_5875504481016333632_modified_192x192_4396c6a8e8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAGMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAGMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

