module 0xfeef37b4fd8c8a8c1f2a9b7b4cbf12fd53677ab1d51d100a344b32b8aa3a7f02::sup {
    struct SUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUP>(arg0, 5, b"SUP", b"Sup X", b"Collab and Earn SUP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgdlvr.com/pic/photoresizer.com/20240615-6916/public")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUP>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUP>>(v2, @0xc632cdf86395750abbe90c0fa557b0567ce7a9a8dc4c104423d7e27f3ff21);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

