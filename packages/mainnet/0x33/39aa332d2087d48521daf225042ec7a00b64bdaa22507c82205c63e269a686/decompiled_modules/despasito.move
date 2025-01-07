module 0x3339aa332d2087d48521daf225042ec7a00b64bdaa22507c82205c63e269a686::despasito {
    struct DESPASITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DESPASITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DESPASITO>(arg0, 9, b"DESPASITO", b"Uos_h", b"Good job and awsome", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a91c91b-95a4-462a-b864-f4259d44f493.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DESPASITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DESPASITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

