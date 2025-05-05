module 0x53f9c903f870284e113c34ce99295d479d1a020f38bccd1c0be2b8dc97e945a8::btest {
    struct BTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTEST>(arg0, 9, b"Btest", b"Btest", b"its a test just chill.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTEST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTEST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

