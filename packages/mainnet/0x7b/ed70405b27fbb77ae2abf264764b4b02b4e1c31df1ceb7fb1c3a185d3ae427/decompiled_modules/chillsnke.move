module 0x7bed70405b27fbb77ae2abf264764b4b02b4e1c31df1ceb7fb1c3a185d3ae427::chillsnke {
    struct CHILLSNKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLSNKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLSNKE>(arg0, 6, b"CHILLSNKE", b"Chill Snake", b"JOIN FORCES WITH CHILL SNAKE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chill_01_91c8e81d5d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLSNKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLSNKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

