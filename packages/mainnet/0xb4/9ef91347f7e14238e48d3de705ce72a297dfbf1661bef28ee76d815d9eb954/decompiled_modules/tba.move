module 0xb49ef91347f7e14238e48d3de705ce72a297dfbf1661bef28ee76d815d9eb954::tba {
    struct TBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBA>(arg0, 6, b"TBA", b"TUBA", b"No1 YouTube Shark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_16_12_55_45_ade00aa148.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

