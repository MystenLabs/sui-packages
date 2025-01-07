module 0x34cc5d97cbcd7f6a6720727562866f714ccfec791f5833d82deefa0276a3e733::mega {
    struct MEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGA>(arg0, 9, b"MEGA", b"Megalodon", b"MEGA is BIG queen of Indonesia former. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/812237a8-7104-44ed-bdba-97411ab3a0c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

