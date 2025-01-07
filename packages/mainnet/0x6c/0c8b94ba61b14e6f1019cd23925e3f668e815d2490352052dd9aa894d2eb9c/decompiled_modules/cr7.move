module 0x6c0c8b94ba61b14e6f1019cd23925e3f668e815d2490352052dd9aa894d2eb9c::cr7 {
    struct CR7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR7>(arg0, 9, b"CR7", b"Ronaldo", b"Buy cr7 siuuuuuuu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4396887-d435-44ff-bd53-681cf92e4b90.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR7>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CR7>>(v1);
    }

    // decompiled from Move bytecode v6
}

