module 0xf5fe9415957d3d0b65c7d4fcae33b90913a6f01dd0e1178039ad5a805f4e1c85::mkd {
    struct MKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKD>(arg0, 9, b"MKD", b"Macedonia ", b"Alexander the Great, created one of the largest empires of the ancient world in little over a decade.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc979267-f6a2-4607-9ed5-7ce57968d771.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MKD>>(v1);
    }

    // decompiled from Move bytecode v6
}

