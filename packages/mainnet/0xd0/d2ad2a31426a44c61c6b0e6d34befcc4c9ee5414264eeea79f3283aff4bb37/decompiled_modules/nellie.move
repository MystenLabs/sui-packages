module 0xd0d2ad2a31426a44c61c6b0e6d34befcc4c9ee5414264eeea79f3283aff4bb37::nellie {
    struct NELLIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NELLIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NELLIE>(arg0, 6, b"NELLIE", b"Nellie Dogs", b"This is Nellie. She couldn't choose between yellow or pink, so she went with both. 13/10 phenomenal decision.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001517762_d58c75ddf4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NELLIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NELLIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

