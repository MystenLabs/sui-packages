module 0x19b7d4f907b2a20ed6a0535806288dd7409049da4d1baa1e49a573e907fce846::gck {
    struct GCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCK>(arg0, 6, b"GCK", b"GECKO", b"GECKOOSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HD_wallpaper_gecko_animal_funny_61126ed684.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

