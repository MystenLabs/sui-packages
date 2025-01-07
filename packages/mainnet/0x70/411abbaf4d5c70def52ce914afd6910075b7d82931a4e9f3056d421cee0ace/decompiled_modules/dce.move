module 0x70411abbaf4d5c70def52ce914afd6910075b7d82931a4e9f3056d421cee0ace::dce {
    struct DCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCE>(arg0, 9, b"DCE", b"DICE", b"it's all about luck for six not two... two six needed not six twos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a763a38-e57f-4cca-b7f0-ac378376ac56.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

