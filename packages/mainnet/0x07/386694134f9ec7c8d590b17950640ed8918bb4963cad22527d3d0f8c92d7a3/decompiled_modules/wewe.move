module 0x7386694134f9ec7c8d590b17950640ed8918bb4963cad22527d3d0f8c92d7a3::wewe {
    struct WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWE>(arg0, 6, b"Wewe", b"Wewepump", b"Official WEWE Token fair Launch  of  Wave wallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029818_dda629d473.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

