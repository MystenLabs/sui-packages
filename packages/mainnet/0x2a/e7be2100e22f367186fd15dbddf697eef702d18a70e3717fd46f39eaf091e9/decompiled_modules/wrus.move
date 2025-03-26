module 0x2ae7be2100e22f367186fd15dbddf697eef702d18a70e3717fd46f39eaf091e9::wrus {
    struct WRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRUS>(arg0, 6, b"WRUS", b"Wolrus", b"Wolrus is a mad walrus who has escaped from the ice floe to wreak havoc on SUI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012153_68caab0164.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

