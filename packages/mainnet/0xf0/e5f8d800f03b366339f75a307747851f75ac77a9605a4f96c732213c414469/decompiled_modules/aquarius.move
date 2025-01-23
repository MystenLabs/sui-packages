module 0xf0e5f8d800f03b366339f75a307747851f75ac77a9605a4f96c732213c414469::aquarius {
    struct AQUARIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUARIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUARIUS>(arg0, 6, b"AQUARIUS", b"Aquarius", b"Unleash the cosmic power of our Aquarius, the water  bearer hero Memecoin! Featuring a superhero adorned in futuristic armor, he symbolizes creativity and freedom with flowing water elements. Join the zodiac revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737653229403.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AQUARIUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUARIUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

