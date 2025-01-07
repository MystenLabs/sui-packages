module 0xfa18b9d1b933024d1636564567664e4402c4ba0059a5172d7839140b5033adf5::dab {
    struct DAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAB>(arg0, 9, b"DAB", b"Dab", b"Dab is a memecoin inspired by a popular song which trended in Nigeria years back ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da57352a-bd4f-402f-b798-321020f35512.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

