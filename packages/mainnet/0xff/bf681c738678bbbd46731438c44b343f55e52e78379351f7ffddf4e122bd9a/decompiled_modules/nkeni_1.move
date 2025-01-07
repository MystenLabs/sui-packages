module 0xffbf681c738678bbbd46731438c44b343f55e52e78379351f7ffddf4e122bd9a::nkeni_1 {
    struct NKENI_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NKENI_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NKENI_1>(arg0, 9, b"NKENI_1", b"Phil ", b"Creating wealth to make life easier for my love ones ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3a20cb91-83ff-4574-87cf-a59ab1222910.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NKENI_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NKENI_1>>(v1);
    }

    // decompiled from Move bytecode v6
}

