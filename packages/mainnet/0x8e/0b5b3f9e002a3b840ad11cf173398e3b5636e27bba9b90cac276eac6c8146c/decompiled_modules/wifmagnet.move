module 0x8e0b5b3f9e002a3b840ad11cf173398e3b5636e27bba9b90cac276eac6c8146c::wifmagnet {
    struct WIFMAGNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFMAGNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFMAGNET>(arg0, 6, b"WIFMAGNET", b"DOG WIF MAGNET", b"Dog wif magnet on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3680_5483127b15.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFMAGNET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFMAGNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

