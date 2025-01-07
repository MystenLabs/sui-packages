module 0x953ef468f457d1c648ebe9ad4cbba743eb6832ea79530b030dd059de02a2b401::suialien {
    struct SUIALIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIALIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIALIEN>(arg0, 6, b"SUIALIEN", b"SUI Aliens", b"Aliens are here to takeover SUI network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_Copy_2479408017.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIALIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIALIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

