module 0x317a0d716c3842f6b5aecc47b0a5b89c6d3a9aa015a32d6c05de3acc27344e43::salami {
    struct SALAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALAMI>(arg0, 9, b"Salami", b"salami", b"SALAMISALAMISALAMISALAMISALAMISALAMISALAMISALAMISALAMISALAMISALAMISALAMISALAMISALAMISALAMISALAMISALAMISALAMI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWgbl6p3EdUTLc6fbuIZ8phYRxLIcZwPvNOg&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SALAMI>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALAMI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

