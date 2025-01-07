module 0x30557bda98d6bb71e98b613d86cdc27928b3ae0014111ca8e2ed7f9657a01817::roy {
    struct ROY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROY>(arg0, 9, b"ROY", b"Hate Roy", b"Ah ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a8004ce-9d3c-40d8-81c4-b95b7601cd4d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROY>>(v1);
    }

    // decompiled from Move bytecode v6
}

