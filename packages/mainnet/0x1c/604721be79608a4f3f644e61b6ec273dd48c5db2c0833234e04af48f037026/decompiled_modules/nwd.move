module 0x1c604721be79608a4f3f644e61b6ec273dd48c5db2c0833234e04af48f037026::nwd {
    struct NWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NWD>(arg0, 9, b"nwd", b"Narwood", b"Narwood is a fast and secure cryptocurrency designed for everyday transactions and micro-payments. It utilizes a unique hybrid consensus algorithm that combines proof-of-stake and proof-of-work to ensure maximum security and efficiency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NWD>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NWD>>(v2, @0xda45d63855b97c771449986808b7f77bc5cfb24948f6d2112257537198f0c5ef);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NWD>>(v1);
    }

    // decompiled from Move bytecode v6
}

