module 0x422ddbe0478e3f101cceb6ab1d8a11ecbe91ef08993d7fdc37788fdf956cf9ae::again {
    struct AGAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGAIN>(arg0, 6, b"AGAIN", b"GREAT AGAIN...", b"Grate Again...Grate Again...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Donald_Trump_Eating_Hamburger_Crying_42323512_1_9edcd69899.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

