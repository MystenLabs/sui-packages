module 0x89cf3f4e318423c802e3b96a2cf50babdf4cf3b5454308a9ab4f83ae2121f42e::satsui {
    struct SATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATSUI>(arg0, 6, b"SATSUI", b"SATOSHISUI$", b"The Meme Coin That Blends Satoshis Vision with Sui Blockchain Power!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b161b6477d3ec487c1c027ca09a6b3fe083d92f3_e5709ab1c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

