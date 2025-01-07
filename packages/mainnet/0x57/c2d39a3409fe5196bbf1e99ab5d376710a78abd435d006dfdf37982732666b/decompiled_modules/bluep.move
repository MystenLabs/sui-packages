module 0x57c2d39a3409fe5196bbf1e99ab5d376710a78abd435d006dfdf37982732666b::bluep {
    struct BLUEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEP>(arg0, 6, b"BLUEP", b"blue eyed pepe", b"A blue eyed pepe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bluue_cb6a677e5e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

