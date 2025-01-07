module 0xbfdfcb7dc3c8e9503ad514fcf24d2e556744b7e10547410480788ab41ba12708::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 9, b"FISH", b"FISHMAN", b"A Lonely Fish in the Waters of the Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1823309778275151872/IkArJ4yv_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FISH>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

