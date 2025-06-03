module 0x14e7488759d9e202a4312fc7236d705ace6c90a587f341debb74778aaca4dbc6::Zu {
    struct ZU has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZU>, arg1: 0x2::coin::Coin<ZU>) {
        0x2::coin::burn<ZU>(arg0, arg1);
    }

    fun init(arg0: ZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZU>(arg0, 6, b"ZU", b"Zu", b"DaiZu 69", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/logo.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

