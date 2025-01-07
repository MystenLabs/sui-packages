module 0x180667a0188a62479c85dd9b28842c93a24ca294a01f627598d80c6eac029548::winter {
    struct WINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINTER>(arg0, 6, b"WINTER", b"Trump Family Dog", b"the Trump Family Dog project! Meet WINTER, the ultimate meme machine and the coolest pup in crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Winter_f5bcf6f9ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

