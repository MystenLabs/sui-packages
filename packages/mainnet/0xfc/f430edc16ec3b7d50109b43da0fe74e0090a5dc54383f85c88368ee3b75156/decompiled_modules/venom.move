module 0xfcf430edc16ec3b7d50109b43da0fe74e0090a5dc54383f85c88368ee3b75156::venom {
    struct VENOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: VENOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VENOM>(arg0, 9, b"VENOM", b"SYMBIONT", b"Something majestic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://c4.wallpaperflare.com/wallpaper/658/887/815/movie-venom-wallpaper-preview.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VENOM>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VENOM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VENOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

