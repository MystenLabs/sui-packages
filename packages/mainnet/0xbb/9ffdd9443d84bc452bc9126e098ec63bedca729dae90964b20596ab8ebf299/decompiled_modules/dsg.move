module 0xbb9ffdd9443d84bc452bc9126e098ec63bedca729dae90964b20596ab8ebf299::dsg {
    struct DSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSG>(arg0, 9, b"DSG", b"DASF", b"EF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ffdcd12-f932-4dfe-8801-8cf25e30b62d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

