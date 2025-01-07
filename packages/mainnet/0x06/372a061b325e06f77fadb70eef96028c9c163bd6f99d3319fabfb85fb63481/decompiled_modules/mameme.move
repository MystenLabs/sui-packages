module 0x6372a061b325e06f77fadb70eef96028c9c163bd6f99d3319fabfb85fb63481::mameme {
    struct MAMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMEME>(arg0, 6, b"MAMEME", b"MASKMEME", b"Vision meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022006_ad34a53622.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

