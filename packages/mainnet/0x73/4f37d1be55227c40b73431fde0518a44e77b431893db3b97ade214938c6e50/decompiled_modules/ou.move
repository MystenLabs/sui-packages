module 0x734f37d1be55227c40b73431fde0518a44e77b431893db3b97ade214938c6e50::ou {
    struct OU has drop {
        dummy_field: bool,
    }

    fun init(arg0: OU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OU>(arg0, 9, b"OU", b"Jollies ", x"49e280996d20676f696e67206261636b20746f20776f726b206e6f7720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5b066aa-da51-489b-ab4f-e1858cde49d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OU>>(v1);
    }

    // decompiled from Move bytecode v6
}

