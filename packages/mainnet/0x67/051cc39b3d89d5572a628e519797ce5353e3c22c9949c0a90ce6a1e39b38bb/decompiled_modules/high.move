module 0x67051cc39b3d89d5572a628e519797ce5353e3c22c9949c0a90ce6a1e39b38bb::high {
    struct HIGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIGH>(arg0, 9, b"HIGH", b"Higher", b"Only Higher moonland on the way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1766836912449372160/bLjA4XNU.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIGH>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIGH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

