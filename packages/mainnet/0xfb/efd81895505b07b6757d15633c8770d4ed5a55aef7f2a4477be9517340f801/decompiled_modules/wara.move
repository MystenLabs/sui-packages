module 0xfbefd81895505b07b6757d15633c8770d4ed5a55aef7f2a4477be9517340f801::wara {
    struct WARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARA>(arg0, 6, b"WARA", b"WaraWara", b"Originating from the lore of The Boy and the Heron, which i am a big fan of and Studio Ghibli's other films, the Warawara are unborn human souls who reside in the Sea World. When they mature, they fly up into the sky to be born as humans.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/warawara_is_e21f439ccc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

