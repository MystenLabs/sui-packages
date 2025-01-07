module 0x3dfc2a0f43734fc36498192cdca1411d136d55927018ddc605375c7038e3305f::mng {
    struct MNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNG>(arg0, 6, b"MNG", b"Ming Ming", b"Just A Cute Cat On Sui *_^", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6672_93cbcc2250.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

