module 0x91bf2ddcbbc51ad599d9b009eddcc258a87a8a828a95c37da48040f5ba768f3b::cr7siu {
    struct CR7SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR7SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR7SIU>(arg0, 9, b"CR7SIU", b"Siuuuuuuuu", b"Siuuuuuuuuuuu inspired by cr7 ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/27e69c90-913e-4aca-aa9a-b857cb34d342.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR7SIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CR7SIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

