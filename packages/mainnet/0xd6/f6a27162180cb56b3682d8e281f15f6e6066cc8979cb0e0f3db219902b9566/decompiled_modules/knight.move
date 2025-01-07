module 0xd6f6a27162180cb56b3682d8e281f15f6e6066cc8979cb0e0f3db219902b9566::knight {
    struct KNIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNIGHT>(arg0, 9, b"KNIGHT", b"Iluminacja", b"you cannot become a knight of the order before you are born, deep in your soul and heart enter the world of illumination and follow the path of the ancient order", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6d6a20b-1af7-4697-97dc-553e94ccb830.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KNIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

