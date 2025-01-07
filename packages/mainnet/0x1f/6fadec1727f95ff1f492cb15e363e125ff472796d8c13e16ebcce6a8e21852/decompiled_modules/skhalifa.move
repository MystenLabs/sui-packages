module 0x1f6fadec1727f95ff1f492cb15e363e125ff472796d8c13e16ebcce6a8e21852::skhalifa {
    struct SKHALIFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKHALIFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKHALIFA>(arg0, 6, b"SKhalifa", b"Suiz Khalifa", b"The chillest meme token on the Sui Network, blending crypto vibes with Rasta fish energy. Suiz Khalifa is here to bring fin-tastic fun and waves of community-driven growth. Whether you're a crypto enthusiast, a meme lover, or just want to ride the vibes, this token is your ticket to the underwater reggae revolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018825_6377295202.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKHALIFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKHALIFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

