module 0xdc3ce914663455c05b0f4c5bc7798bab6794907d2036af0017c723efa0a8297c::nobel {
    struct NOBEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOBEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBEL>(arg0, 6, b"Nobel", b"Alfred Bernh", b"https://edition.cnn.com/2024/10/05/science/nobel-prize-worthy-science-discoveries/index.html", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728284949435_4c0ce457ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOBEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

