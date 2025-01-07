module 0x48bb3b73db7841bc9cc10df93cb88099903a9c88d4ae8e0307b52a173798fda6::beni {
    struct BENI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENI>(arg0, 6, b"BENI", b"Beni", x"546865202453554920636f6d6d756e697479206973207468652062657374f09f94a5686572652061726520637573746f6d6973656420504650732049206861766520726563656976656420736f20666172", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730994546880.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BENI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

