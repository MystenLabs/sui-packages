module 0x9bdf1bf471e2468a0741ef9d6d567ce0c84907e760ee1013bab9912c31a3e51f::anna {
    struct ANNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANNA>(arg0, 6, b"Anna", b"Anna", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/9f677add-d6e5-4df5-8d4c-74c497202d35.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANNA>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANNA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

