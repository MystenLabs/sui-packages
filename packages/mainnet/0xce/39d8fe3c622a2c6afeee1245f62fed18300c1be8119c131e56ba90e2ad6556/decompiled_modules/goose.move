module 0xce39d8fe3c622a2c6afeee1245f62fed18300c1be8119c131e56ba90e2ad6556::goose {
    struct GOOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOSE>(arg0, 9, b"GOOSE", b"GoGoose", b"Geese are large birds with loud, honking calls. Along with ducks and swans, they belong to a group of birds called waterfowl in North America and wildfowl in Europe. They call are ga-ga-ga and they can make hurt.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04d3ba2e-3e66-4c80-8abb-6a2760f6d5de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOOSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

