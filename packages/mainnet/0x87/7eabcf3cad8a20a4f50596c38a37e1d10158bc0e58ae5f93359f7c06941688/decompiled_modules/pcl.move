module 0x877eabcf3cad8a20a4f50596c38a37e1d10158bc0e58ae5f93359f7c06941688::pcl {
    struct PCL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCL>(arg0, 9, b"PCL", b"Picolo", b"PICOLO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc38960f-ce0b-4d3c-8de1-a3e0cb5c18a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PCL>>(v1);
    }

    // decompiled from Move bytecode v6
}

