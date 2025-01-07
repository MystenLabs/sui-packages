module 0x8510b037edab2681324cbe598c37bf23aff9392d5644f6f29216dbb601cf76f::lamane {
    struct LAMANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMANE>(arg0, 9, b"LAMANE", b"Alaman", b"Great coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/386858ff-4b2b-4100-ac95-0b793d8a472c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMANE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMANE>>(v1);
    }

    // decompiled from Move bytecode v6
}

