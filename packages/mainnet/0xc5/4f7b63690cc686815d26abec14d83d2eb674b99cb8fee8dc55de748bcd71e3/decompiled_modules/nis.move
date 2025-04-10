module 0xc54f7b63690cc686815d26abec14d83d2eb674b99cb8fee8dc55de748bcd71e3::nis {
    struct NIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIS>(arg0, 6, b"NIS", b"Noise", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/45208840-d8a8-11ef-8165-f761f2caed44")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIS>>(v1);
        0x2::coin::mint_and_transfer<NIS>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

