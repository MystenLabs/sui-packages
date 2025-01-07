module 0xd81a1661fcc592d75216333694f5d4c52feea61fc2953dae46245cc2fcfccb9c::jjjsiiiqlk {
    struct JJJSIIIQLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JJJSIIIQLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJJSIIIQLK>(arg0, 9, b"JJJSIIIQLK", b"Nka", b"Jjjsjjkkakw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35696c9f-6617-4d10-847e-d9e81c92c7e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJJSIIIQLK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JJJSIIIQLK>>(v1);
    }

    // decompiled from Move bytecode v6
}

