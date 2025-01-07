module 0x2f2a942810bf4d64bc890f2a9dff3b9fe57acf4b37eab7e8989414359948d04c::ottr {
    struct OTTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTR>(arg0, 9, b"OTTR", b"Otter", b"Happy Otter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/846c4e60-60ca-44c5-96cb-a77da349068f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

