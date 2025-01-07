module 0x9701c67cfed0fce99d84b50d66cdfbe53c6b4b3094342d6209659c048b1512e::georgesui {
    struct GEORGESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEORGESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEORGESUI>(arg0, 6, b"GEORGESUI", b"GEORGE THE DUCK", b"THE BIGGEST OF THE DUCKS HAS ARRIVED AT MOVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_19_344808e2b4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEORGESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEORGESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

