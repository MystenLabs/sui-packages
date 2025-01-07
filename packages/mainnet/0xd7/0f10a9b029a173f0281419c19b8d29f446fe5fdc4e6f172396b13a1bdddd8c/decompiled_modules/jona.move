module 0xd70f10a9b029a173f0281419c19b8d29f446fe5fdc4e6f172396b13a1bdddd8c::jona {
    struct JONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JONA>(arg0, 6, b"JONA", b"Jona - Moo Dengs Mom", b"Jona gave birth to legendary Moo Deng on July 10th, 2024. This project is to show support for Jona and incredible mothers around the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jona_9781eb74eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

