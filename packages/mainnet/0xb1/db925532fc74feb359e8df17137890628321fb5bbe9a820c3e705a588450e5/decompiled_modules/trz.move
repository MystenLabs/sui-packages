module 0xb1db925532fc74feb359e8df17137890628321fb5bbe9a820c3e705a588450e5::trz {
    struct TRZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRZ>(arg0, 6, b"TRZ", b"Tree for the planet Earth", b"Trz is the governance token for TRZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRZ>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRZ>>(v2, @0xc1e3eb64981a7db8378e77de783ef3834820715e3905d5c12dedfcdde7a571f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

