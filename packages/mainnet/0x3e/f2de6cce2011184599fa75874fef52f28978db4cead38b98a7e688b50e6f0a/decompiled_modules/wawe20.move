module 0x3ef2de6cce2011184599fa75874fef52f28978db4cead38b98a7e688b50e6f0a::wawe20 {
    struct WAWE20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWE20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWE20>(arg0, 9, b"WAWE20", b"Bobowawe ", b"Enjoy the fun  Tsunami", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/37c41daf-4b5e-4551-b9ad-014185cce3b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWE20>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAWE20>>(v1);
    }

    // decompiled from Move bytecode v6
}

