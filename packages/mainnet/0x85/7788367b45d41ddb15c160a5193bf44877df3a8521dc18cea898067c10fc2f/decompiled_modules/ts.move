module 0x857788367b45d41ddb15c160a5193bf44877df3a8521dc18cea898067c10fc2f::ts {
    struct TS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TS>(arg0, 6, b"TS", b"Tomb Suider", b"For all fans of this cult film and game but also for all fans of pretty women.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tomb_raider_alicia_vikander_164b679b01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TS>>(v1);
    }

    // decompiled from Move bytecode v6
}

