module 0x2e0a3a35c74544d36ef41f2c25d954d3bb2258cf9f7aeac08b8d85782b7cc682::starplatinum {
    struct STARPLATINUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARPLATINUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARPLATINUM>(arg0, 9, b"STAR", b"starplatinum", b"Thread Writer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1851357565348610048/sJHnx67Q_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STARPLATINUM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARPLATINUM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

