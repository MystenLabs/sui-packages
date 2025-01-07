module 0x37a405c3f9b4dbed2fbdc9a8c9ebaeb79dc221edf95f06595b3862b3d5bd0f0b::ac {
    struct AC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AC>(arg0, 9, b"AC", b"AnimeCoin", b"Anime Coin Create is completed. Project is Anime Episodes And Movies. Toys Products is Sell Trading is future is Pumping for Coin Up Successfully.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23f7844e-ea4d-43fd-bc58-813d39744b3b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AC>>(v1);
    }

    // decompiled from Move bytecode v6
}

