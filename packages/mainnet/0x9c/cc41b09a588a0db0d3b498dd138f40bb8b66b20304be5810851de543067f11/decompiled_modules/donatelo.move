module 0x9ccc41b09a588a0db0d3b498dd138f40bb8b66b20304be5810851de543067f11::donatelo {
    struct DONATELO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONATELO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONATELO>(arg0, 9, b"DONATELO", b"Donate", b"Dantelodog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e554f276-bb42-4099-aea8-a9f934c8dea7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONATELO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONATELO>>(v1);
    }

    // decompiled from Move bytecode v6
}

