module 0xa86b32d6e265635b3801dcec034174c1715f52e084995d72510687c5a21558b2::ck {
    struct CK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CK>(arg0, 9, b"CK", b"Chicken", b"Chiken foam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/97f4ca84-e97a-490f-a481-1f321617dc9a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CK>>(v1);
    }

    // decompiled from Move bytecode v6
}

