module 0x8d4c3040bdd635edbba34b9b82c6f88f39e95b875363fc0bbddd524d55204d5e::fcat {
    struct FCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCAT>(arg0, 6, b"FCAT", b"FlyCat on SUI", b"There was a big wave of bots, and it will take a long time to weed them out!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rt5_E9_V_p_400x400_d710994550.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

