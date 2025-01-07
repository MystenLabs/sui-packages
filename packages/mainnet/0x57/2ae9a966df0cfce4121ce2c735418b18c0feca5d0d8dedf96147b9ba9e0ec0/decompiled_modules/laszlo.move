module 0x572ae9a966df0cfce4121ce2c735418b18c0feca5d0d8dedf96147b9ba9e0ec0::laszlo {
    struct LASZLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LASZLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LASZLO>(arg0, 6, b"Laszlo", b"10.000 BTC for 2 pizza", b"On May 22, 2010, a man in Florida paid 10,000 Bitcoin for pizza. When Laszlo Hanyecz bought two pizzas from Papa John's that day, it was considered to be the first ever purchase with Bitcoin. The transaction paved the way for the financial revolution brought about by cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2pizza_5c1f0bbd7c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LASZLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LASZLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

