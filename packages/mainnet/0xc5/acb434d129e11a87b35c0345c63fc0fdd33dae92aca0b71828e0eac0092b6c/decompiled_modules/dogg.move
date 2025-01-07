module 0xc5acb434d129e11a87b35c0345c63fc0fdd33dae92aca0b71828e0eac0092b6c::dogg {
    struct DOGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGG>(arg0, 9, b"DOGG", b"Doggo", b"Doggo is best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7dbb7bf9-b9c4-4844-9fc7-71f34205673b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

