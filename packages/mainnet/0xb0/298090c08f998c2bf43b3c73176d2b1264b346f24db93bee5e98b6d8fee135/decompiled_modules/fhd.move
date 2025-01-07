module 0xb0298090c08f998c2bf43b3c73176d2b1264b346f24db93bee5e98b6d8fee135::fhd {
    struct FHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHD>(arg0, 9, b"FHD", b"GSD", b"FGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c533bd40-6ad8-439b-83d9-d047ad95dc4b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

