module 0xba6009a872d851bfb21a83acad7f8196ff787a3d579ade2156f9d0140ad36ad0::myfirstbab {
    struct MYFIRSTBAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYFIRSTBAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYFIRSTBAB>(arg0, 9, b"MYFIRSTBAB", b"Mybaby", b"My first baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/57257641-b202-4e88-b315-cd38f3d789fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYFIRSTBAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYFIRSTBAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

