module 0xad7202881ea7f93e0c2ffbe873097d441f3a1c3bdda4adcf2ab6708d8bf7efc6::clb {
    struct CLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLB>(arg0, 9, b"CLB", b"CuLiBa", b"troll vietnam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e8f67a8-2475-4fa9-baca-07f9891b6a88.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

