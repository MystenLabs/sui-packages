module 0x5dee5e67beb4bcde221fde62747317cd99949f046c699e374028cf56af02aaef::shart {
    struct SHART has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHART>(arg0, 6, b"SHART", b"SHARTCOIN", b"Welcome to the worlds first cryptocurrency backed by beans, dreams and digestive extremes. Born during times of panic, propelled by pressure, and celebrated in silence. Its only natural the water chain has the wet fart.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_06_17_231728_0d41612fb4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHART>>(v1);
    }

    // decompiled from Move bytecode v6
}

