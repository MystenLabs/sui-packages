module 0x6da233e13be55a535bb7b667d1893920dc2d230f6011474ab0ab41f64e35388e::utc {
    struct UTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: UTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UTC>(arg0, 6, b"UTC", b"UltraTrash Coin", b"Introducing UltraTrash Coin (UTC), the ultimate memecoin that sprouted from the bold statement by influencer Murad, who famously dubbed memeland as \"ultra trash.\" Well, if memeland can be the top gainer while being labeled as such, why not celebrate the absurdity with our very own UltraTrashtoken?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/utc_Logo_neu_f7099cc9e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

