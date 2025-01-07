module 0x960d62556a96bea483b61d5e799b57c1d4fa35327eb426f1c935a7ec12d0178e::bobby {
    struct BOBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBBY>(arg0, 6, b"Bobby", b"Bobby Dazzler", b"The real Bobby Dazzler!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7195_75821c0d53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

