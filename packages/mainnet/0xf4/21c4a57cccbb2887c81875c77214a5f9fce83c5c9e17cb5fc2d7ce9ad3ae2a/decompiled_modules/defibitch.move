module 0xf421c4a57cccbb2887c81875c77214a5f9fce83c5c9e17cb5fc2d7ce9ad3ae2a::defibitch {
    struct DEFIBITCH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DEFIBITCH>, arg1: 0x2::coin::Coin<DEFIBITCH>) {
        0x2::coin::burn<DEFIBITCH>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEFIBITCH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEFIBITCH>>(0x2::coin::mint<DEFIBITCH>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DEFIBITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEFIBITCH>(arg0, 9, b"DEFIBITCH", b"DEFIBITCH", b"test token for the video", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"example.com")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEFIBITCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFIBITCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

