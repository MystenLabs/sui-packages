module 0x3588aca7747f3ce2ce8d5134784fc117c1614c520b5e418ca047227fbe3a9064::hcat {
    struct HCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCAT>(arg0, 6, b"HCAT", b"HELLCAT", b"NICE RED CAR ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hellcat_wallpaper_f7b3d2b623.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

