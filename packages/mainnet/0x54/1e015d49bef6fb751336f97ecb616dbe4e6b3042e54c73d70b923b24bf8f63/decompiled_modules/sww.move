module 0x541e015d49bef6fb751336f97ecb616dbe4e6b3042e54c73d70b923b24bf8f63::sww {
    struct SWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWW>(arg0, 9, b"SWW", b"swan", b"beautiful white", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/95be34c5-b75d-4e86-bfe7-910cfeb81fdd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

