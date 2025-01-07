module 0xca6e0338b68648df904f79f4d2685f0f413c02d395bff00b7de3451197c1739a::shldn {
    struct SHLDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHLDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHLDN>(arg0, 9, b"SHLDN", b"SHeLDoN", b"chihuahua", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66499997-eebf-4fca-8954-db41aa46b52f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHLDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHLDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

