module 0x922a96bd8b0665f97da2dd82a6dbe9e0b2f055c881dbdd0e3570088046d159c8::suitoshi {
    struct SUITOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOSHI>(arg0, 6, b"SUITOSHI", b"Suitoshi Nakomoto", b"Imagine the wisdom of Satoshi Nakamoto infused with the unstoppable momentum of a powerful wave. Suitoshi Nakomoto rides the crest of the Sui Blockchain, harnessing both the force and finesse of a seasoned surfer navigating the vast crypto ocean. This isnt just another tokenits a fusion of cutting-edge technology and visionary leadership, pushing through the market with the speed and precision of a master. Suitoshi represents the perfect balance of innovation and control, shaping the future of digital currency with the same groundbreaking impact Nakamoto brought to the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_05_26_26_5e3a58c941.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

