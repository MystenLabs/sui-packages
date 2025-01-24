module 0xf96b65af3818b7d33bbc7058683b1fd9c621384df240121dbc2a6fb49e5df3b3::lingobot {
    struct LINGOBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINGOBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINGOBOT>(arg0, 6, b"LINGOBOT", b"LingoBot", b"LingoBot - Revolutionizing the way you interact with technology through natural, intelligent communication.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028897_d4eb88cf0a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINGOBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LINGOBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

