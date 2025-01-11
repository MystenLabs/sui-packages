module 0x2990bf0b3fa88edd7b78ca002aaafffc6f463efc15178278590b53f23957402e::fls {
    struct FLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLS>(arg0, 6, b"FLS", b"FELIX", b"I'm from ETH, give me some time I'll update all the things we need, we have a new path for the future and most of all now what we're aiming for in the presale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_12_00_10_54_59f572a6b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

