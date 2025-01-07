module 0x8606c8863304d662002a037b61b632a91351ba4f1dbbbced0978b6e9c9d72e46::pizza {
    struct PIZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZZA>(arg0, 9, b"PIZZA", b"Pizzaday", x"4f6e204d61792032322c20323031302c206120466c6f72696461206d616e206d61646520686973746f727920627920627579696e672074776f2070697a7a617320776974682031302c30303020426974636f696e732e204c6574e2809973206d616b652066756e20776974682074686973206d656d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f3e63a7-7656-4b56-acac-01c55d815e56.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIZZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

