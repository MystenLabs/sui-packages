module 0x2adeec300c468659d3e9ed8f889433a115129789a3ad59cf19ccdcb0ad468478::payesh {
    struct PAYESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAYESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAYESH>(arg0, 9, b"PAYESH", b"Mori", b"just wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4f571df-e013-402a-86d9-d48f523716b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAYESH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAYESH>>(v1);
    }

    // decompiled from Move bytecode v6
}

