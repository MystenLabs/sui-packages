module 0x78b39fc8c9669908382bfd143643dea2043bd87db2c58019d5374c03d8f74844::puggy {
    struct PUGGY has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"PUGGY", b"PUGGY", b"PUGGY the memecoin for everyone! Join a vibrant community driven by hard work and humor as we embark on a fun-filled ride to the moon and beyond.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FIMG_20241018_135856_658_39f80fb2ba.jpg&w=256&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: PUGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<PUGGY>(arg0, arg1);
        0x2::coin::mint_and_transfer<PUGGY>(&mut v0, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGGY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

