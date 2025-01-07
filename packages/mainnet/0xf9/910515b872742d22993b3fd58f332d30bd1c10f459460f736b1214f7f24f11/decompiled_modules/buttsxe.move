module 0xf9910515b872742d22993b3fd58f332d30bd1c10f459460f736b1214f7f24f11::buttsxe {
    struct BUTTSXE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTSXE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTTSXE>(arg0, 6, b"BUTTSXE", b"Buttsxe", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"buttsxe")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUTTSXE>(&mut v2, 69000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTSXE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTTSXE>>(v1);
    }

    // decompiled from Move bytecode v6
}

