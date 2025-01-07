module 0x23cf4b9e9f9758b684953abbb53de04279142c224b804169e29451eb3f97e90a::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUMP>(arg0, 9, b"SUIPUMP", b"SUI PUMP", b"Suipump is a token that will continue to pump following sui. Suipump is the hope for all sui holders. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54e355ef-31b4-4bfd-8fb5-33c750b0c2e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

