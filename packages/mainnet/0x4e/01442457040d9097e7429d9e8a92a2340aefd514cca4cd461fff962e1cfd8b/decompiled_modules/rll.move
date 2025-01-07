module 0x4e01442457040d9097e7429d9e8a92a2340aefd514cca4cd461fff962e1cfd8b::rll {
    struct RLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RLL>(arg0, 9, b"RLL", b"THE NIGHT", b"Nocturnal adventures and legends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/28ba8cbb-332b-4105-8d97-6ddb18ea1327.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

