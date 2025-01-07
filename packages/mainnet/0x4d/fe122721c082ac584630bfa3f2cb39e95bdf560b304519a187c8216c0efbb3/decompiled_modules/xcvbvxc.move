module 0x4dfe122721c082ac584630bfa3f2cb39e95bdf560b304519a187c8216c0efbb3::xcvbvxc {
    struct XCVBVXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: XCVBVXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XCVBVXC>(arg0, 9, b"XCVBVXC", b"SGDFGS", b"MJH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0d3f306-ff10-4c34-b6e0-30ac8cf76a75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XCVBVXC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XCVBVXC>>(v1);
    }

    // decompiled from Move bytecode v6
}

