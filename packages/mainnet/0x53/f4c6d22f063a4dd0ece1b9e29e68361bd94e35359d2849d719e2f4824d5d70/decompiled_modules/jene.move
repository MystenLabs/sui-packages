module 0x53f4c6d22f063a4dd0ece1b9e29e68361bd94e35359d2849d719e2f4824d5d70::jene {
    struct JENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JENE>(arg0, 9, b"JENE", b"jend", b"bdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c99df81-e51a-4027-9ddb-d7dba4586d7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

