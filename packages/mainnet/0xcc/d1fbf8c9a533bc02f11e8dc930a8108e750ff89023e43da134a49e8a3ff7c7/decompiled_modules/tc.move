module 0xccd1fbf8c9a533bc02f11e8dc930a8108e750ff89023e43da134a49e8a3ff7c7::tc {
    struct TC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TC>(arg0, 9, b"TC", b"Tietcanh", x"5469e1babf742063616e6820636f696e2070756d70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0db8ebab-cf0e-4e59-bc66-a5e3659376cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TC>>(v1);
    }

    // decompiled from Move bytecode v6
}

