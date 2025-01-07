module 0xe15accdd7873a179a58ba9034edab2cb394dfa5c62ba897dea8f433c34640239::bb {
    struct BB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BB>(arg0, 9, b"BB", b"Blackberry", x"496e74726f647563696e6720426c61636b6265727279436f696e3a205468652068696c6172696f75732063727970746f63757272656e63792064657369676e656420746f207469636b6c6520796f75722066756e6e7920626f6e65207768696c652064656c69766572696e67206d656d652d7461737469632070726f666974732120f09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d099e5e-678f-4019-8a95-d4c801868f64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BB>>(v1);
    }

    // decompiled from Move bytecode v6
}

