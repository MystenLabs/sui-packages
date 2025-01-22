module 0xc63de06d91860214ec07e48b62c2f7f3cfd1d4ecdba9879557ff8528211f9dfe::ross {
    struct ROSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSS>(arg0, 6, b"ROSS", b"ROSS IS FREE", b"To celebrate the freedom of Ross Ulbricht, we're launching our official $ROSS coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_153657_894_e1303d8554.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

