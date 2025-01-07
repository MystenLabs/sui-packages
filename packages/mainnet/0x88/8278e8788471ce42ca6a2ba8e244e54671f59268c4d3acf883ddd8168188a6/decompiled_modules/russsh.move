module 0x888278e8788471ce42ca6a2ba8e244e54671f59268c4d3acf883ddd8168188a6::russsh {
    struct RUSSSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSSSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSSSH>(arg0, 9, b"RUSSSH", b"RUSH HOUR ", b"Preparing for the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/503a29ea-b38f-449d-92fb-3f4379cd2294.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSSSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUSSSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

