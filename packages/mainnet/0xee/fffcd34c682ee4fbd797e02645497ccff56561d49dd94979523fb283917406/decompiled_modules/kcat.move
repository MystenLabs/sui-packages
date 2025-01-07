module 0xeefffcd34c682ee4fbd797e02645497ccff56561d49dd94979523fb283917406::kcat {
    struct KCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KCAT>(arg0, 9, b"KCAT", b"Cat killer", x"4c65742773206b696c6c2074686520667265616b696e672063617420f09f98ba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5304db4a-4cb9-4e7c-83d7-2dc56b410b2b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

