module 0xee6c0b21501ccd35d361035567254064348bdc8e0f24606734f8e2e07f234f52::fgg {
    struct FGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGG>(arg0, 9, b"FGG", b"frog", b"Jump up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba0e544d-b216-421f-bdc5-4710aedcc987.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

