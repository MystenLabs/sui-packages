module 0x97042d565339d9e629cff1c8291689dad8b393c8a3578df601503afee0595318::pi {
    struct PI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PI>(arg0, 9, b"PI", b"Pi Network", x"506920e280942043727970746f63757272656e637920666f722065766572796461792070656f706c65206675656c696e672074686520776f726c64e2809973206d6f737420696e636c757369766520706565722d746f2d706565722065636f6e6f6d792e20446f776e6c6f6164206f75722061707020746f207374617274206d696e696e6720506920746f6461792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14421636-4f44-4072-8b36-16f05360bd43.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PI>>(v1);
    }

    // decompiled from Move bytecode v6
}

