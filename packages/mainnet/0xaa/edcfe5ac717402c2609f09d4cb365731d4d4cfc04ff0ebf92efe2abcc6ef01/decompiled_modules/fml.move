module 0xaaedcfe5ac717402c2609f09d4cb365731d4d4cfc04ff0ebf92efe2abcc6ef01::fml {
    struct FML has drop {
        dummy_field: bool,
    }

    fun init(arg0: FML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FML>(arg0, 9, b"FML", b"FAMILY", b"JUST FAMILY , JUST THIS TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2e416c77-e04f-48a7-ae9d-6ee3d8f14a6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FML>>(v1);
    }

    // decompiled from Move bytecode v6
}

