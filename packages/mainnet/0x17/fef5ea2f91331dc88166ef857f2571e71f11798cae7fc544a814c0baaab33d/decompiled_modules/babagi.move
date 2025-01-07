module 0x17fef5ea2f91331dc88166ef857f2571e71f11798cae7fc544a814c0baaab33d::babagi {
    struct BABAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABAGI>(arg0, 9, b"BABAGI", b"Aikilamini", b"Aikilaammababazi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2586bd9-5ab2-4657-953b-663c535f74a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABAGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABAGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

