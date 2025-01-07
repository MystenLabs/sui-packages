module 0xf70567550cc3d3b906a90b0a56e90bf2bb342b6109d3698f257b3257ed76630c::dndn {
    struct DNDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNDN>(arg0, 9, b"DNDN", b"Sjs", b"Dkkdkd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd55a770-2737-449a-92dd-c70d6850515f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

