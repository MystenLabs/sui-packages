module 0xd85f1688790988f45598f2d6ba8f363b546390dd5f967e82681a3dec6efc5dbe::lmb {
    struct LMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMB>(arg0, 9, b"LMB", b"lambo", x"536861726520746865206578636974696e672073746f72696573206f66204c616d626f7267680a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/caa273d6-42fb-49a0-bcbe-4853bd3b02fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

