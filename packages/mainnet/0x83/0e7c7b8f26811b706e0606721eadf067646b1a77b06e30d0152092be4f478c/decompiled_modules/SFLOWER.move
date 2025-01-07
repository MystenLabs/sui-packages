module 0x830e7c7b8f26811b706e0606721eadf067646b1a77b06e30d0152092be4f478c::SFLOWER {
    struct SFLOWER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFLOWER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFLOWER>(arg0, 9, b"SFlower", b"Sui Flower", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/userupload/8716608/file/original-f7b324821b3dcd437b85fa2e27b7a07d.png?resize=1024x768")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFLOWER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SFLOWER>>(0x2::coin::mint<SFLOWER>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SFLOWER>>(v2);
    }

    // decompiled from Move bytecode v6
}

