module 0x25a83d93e270c3362501de8508148e5f1a3ca64287bfb5333cf9a8001c7f13c7::liberty {
    struct LIBERTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBERTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIBERTY>(arg0, 6, b"LIBERTY", b"LIBERTY TRUMP", b"Trump's devotion for liberty is the best example of what the United States of America is.  Make America Liberate Again! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_24_21_24_29_8c3a9e3474.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIBERTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIBERTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

