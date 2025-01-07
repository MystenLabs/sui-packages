module 0xaba37bb48e035cb535947ecba0b42b3e4df60c882d7fc30f43c9723ee92cb508::ashco {
    struct ASHCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASHCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASHCO>(arg0, 9, b"ASHCO", b"ashley_wil", b"Ashly trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b573519-61b8-4ae5-a2d0-efe8462e4a57.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASHCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASHCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

