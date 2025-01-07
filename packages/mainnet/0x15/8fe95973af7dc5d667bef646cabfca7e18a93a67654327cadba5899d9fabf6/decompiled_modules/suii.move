module 0x158fe95973af7dc5d667bef646cabfca7e18a93a67654327cadba5899d9fabf6::suii {
    struct SUII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUII>(arg0, 9, b"SUII", b"Suii Coin", b"Suii is best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4e0e3c8-e5e4-4926-a463-0f13c4bd52e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUII>>(v1);
    }

    // decompiled from Move bytecode v6
}

