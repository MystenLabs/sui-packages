module 0x3f921029b8b70948f610ea391b300850f261d451bdf6c0829eeb60cd100e9ff7::sfj {
    struct SFJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFJ>(arg0, 9, b"SFJ", b"kj", b"gj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/64b97fc1-788b-4b62-81bf-1e100df9453b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

