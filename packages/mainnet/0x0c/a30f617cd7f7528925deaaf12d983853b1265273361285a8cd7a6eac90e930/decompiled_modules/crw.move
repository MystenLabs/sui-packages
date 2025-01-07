module 0xca30f617cd7f7528925deaaf12d983853b1265273361285a8cd7a6eac90e930::crw {
    struct CRW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRW>(arg0, 9, b"CRW", b"CROWW", b"Soar to success with CrowCoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2a24bc4-e34c-4f0d-84c5-317ba5c6cf8f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRW>>(v1);
    }

    // decompiled from Move bytecode v6
}

