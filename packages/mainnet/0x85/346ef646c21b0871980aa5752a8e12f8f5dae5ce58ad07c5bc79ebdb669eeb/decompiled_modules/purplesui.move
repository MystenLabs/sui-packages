module 0x85346ef646c21b0871980aa5752a8e12f8f5dae5ce58ad07c5bc79ebdb669eeb::purplesui {
    struct PURPLESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURPLESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURPLESUI>(arg0, 6, b"Purplesui", b"Pui", x"4e4f207765642c204e6f2054672c204e6f2074776565740a446576206f6e6c792062757920333020737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pui_3f4fbb1781.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURPLESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURPLESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

