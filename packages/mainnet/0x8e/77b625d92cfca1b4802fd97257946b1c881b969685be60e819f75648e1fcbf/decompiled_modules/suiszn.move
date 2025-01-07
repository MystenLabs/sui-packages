module 0x8e77b625d92cfca1b4802fd97257946b1c881b969685be60e819f75648e1fcbf::suiszn {
    struct SUISZN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISZN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISZN>(arg0, 6, b"SUISZN", b"Sui Season", b"Sui Season about to start ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Unbenannt_6b835a1dcb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISZN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISZN>>(v1);
    }

    // decompiled from Move bytecode v6
}

