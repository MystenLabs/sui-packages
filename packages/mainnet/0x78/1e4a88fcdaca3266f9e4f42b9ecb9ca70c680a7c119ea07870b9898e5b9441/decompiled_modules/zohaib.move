module 0x781e4a88fcdaca3266f9e4f42b9ecb9ca70c680a7c119ea07870b9898e5b9441::zohaib {
    struct ZOHAIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOHAIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOHAIB>(arg0, 9, b"ZOHAIB", b"Muhammad", b"This is a nice coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f1e934fe-22a8-4d70-af07-301af74ece09.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOHAIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZOHAIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

