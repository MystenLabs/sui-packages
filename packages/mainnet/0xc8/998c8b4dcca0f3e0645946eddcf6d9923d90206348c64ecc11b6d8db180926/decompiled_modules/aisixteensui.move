module 0xc8998c8b4dcca0f3e0645946eddcf6d9923d90206348c64ecc11b6d8db180926::aisixteensui {
    struct AISIXTEENSUI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AISIXTEENSUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AISIXTEENSUI>>(0x2::coin::mint<AISIXTEENSUI>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: AISIXTEENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AISIXTEENSUI>(arg0, 9, b"AI16SUI", b"AISIXTEENSUI", b"Are you ready for the massive success of ai16sui, a major spin-off of the icon ai agent innovation prepare for the ride its going to be wild!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1730985569243873280/CK55UpfQ_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AISIXTEENSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AISIXTEENSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISIXTEENSUI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

