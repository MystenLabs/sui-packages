module 0x5d4e488d35730c6ce137093bf95c94cfb625075764a1854958e5c6745194238::paw {
    struct PAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAW>(arg0, 6, b"PAW", b"PAW PAW", b"hop hop, grrr grr, woof woof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PAWPAW_9a95d4fbfe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

