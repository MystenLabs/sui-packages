module 0x8e3274a10a4c1e5766b46484c22e5a6e8011a93e99ae864d020c00d38505c2d6::chilpaws {
    struct CHILPAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILPAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILPAWS>(arg0, 6, b"CHILPAWS", b"CHILL PAWS MOON", b"when you are chilpaws and you know that your coin will fly to the moon, just chill paws for SUi let's make SUI great again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007048_a1db57d5a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILPAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILPAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

