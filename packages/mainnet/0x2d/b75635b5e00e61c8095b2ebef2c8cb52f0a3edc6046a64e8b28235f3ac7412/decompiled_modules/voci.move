module 0x2db75635b5e00e61c8095b2ebef2c8cb52f0a3edc6046a64e8b28235f3ac7412::voci {
    struct VOCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOCI>(arg0, 6, b"Voci", b"VOCI AI", b"$VOCI - The ultimate Al platform harnessing the boundlessness of knowledge.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2289_32ea534cfc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOCI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VOCI>>(v1);
    }

    // decompiled from Move bytecode v6
}

