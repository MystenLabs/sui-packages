module 0x8d062c8fbcf5405b095f712edf633ee7f06dba3d49a9e4b4ced585cbd44cb275::wentge {
    struct WENTGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WENTGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WENTGE>(arg0, 6, b"WENTGE", b"WEN TGE", b"Wen TGE ser?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8744_cca21acbbd_57ec8458f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WENTGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WENTGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

