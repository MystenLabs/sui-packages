module 0x6372472dd94775351aaed82c25d48c38bb5715101e9ad7874a4243547f7c7540::wme {
    struct WME has drop {
        dummy_field: bool,
    }

    fun init(arg0: WME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WME>(arg0, 9, b"WME", b"WEME", b"Memecoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/887ee8d1-73f0-4087-8411-9e3f4cdc5272.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WME>>(v1);
    }

    // decompiled from Move bytecode v6
}

