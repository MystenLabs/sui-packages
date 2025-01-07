module 0x3f0eb70f141adb043a85000ad914389298011b28532bf4a3d56935309e7e767f::rr {
    struct RR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RR>(arg0, 6, b"RR", b"rugroy", b"Roy is dev but always get rugged by scam projects. Roy is sad. Let's help Roy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_3ffcc6c677.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RR>>(v1);
    }

    // decompiled from Move bytecode v6
}

