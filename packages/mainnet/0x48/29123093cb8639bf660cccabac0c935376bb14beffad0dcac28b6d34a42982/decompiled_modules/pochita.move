module 0x4829123093cb8639bf660cccabac0c935376bb14beffad0dcac28b6d34a42982::pochita {
    struct POCHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCHITA>(arg0, 9, b"POCHITA", b"PochitaSUI", b"The First POCHITA on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76a52733-011b-4bab-9a95-548aa1e7cd6b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POCHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

