module 0x58536d01137093b4a06c34f89588edf16244ed41ce6d83d89acc0f42a8e1ff2::suix {
    struct SUIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIX>(arg0, 6, b"SUIX", b"Suimaniac", b"You dont have Suimaniac (SUIX) yet? Its like losing your free wifi in the middle of the city. Dont miss out on this chance, join the future!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/robo_1ebfe3aaf9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

