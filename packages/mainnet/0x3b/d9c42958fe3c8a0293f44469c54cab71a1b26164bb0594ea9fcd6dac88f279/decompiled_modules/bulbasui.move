module 0x3bd9c42958fe3c8a0293f44469c54cab71a1b26164bb0594ea9fcd6dac88f279::bulbasui {
    struct BULBASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULBASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULBASUI>(arg0, 6, b"BULBASUI", b"BulbaSUI", b"Im Bulbasaur, the iconic grass-type Pokmon, now thriving on the Sui Chain! My mission? To plant seeds of innovation, grow a strong community, and evolve into something truly legendary in the crypto space. Together, well build, bloom, and reach new heights!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bulba_031b95b542.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULBASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULBASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

