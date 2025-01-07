module 0x304fbebf92958475ab34d437ad579b8dcb29c18f58e0776ab548941b09c9dc93::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 9, b"SUI", b"TRINTI", b"TRINTI,Like other cryptocurrencies,it operates on a peer-to-peer network and uses blockchain technology to securely process transactions.This token is created by True Income Tips channel.You can use it safely.Yous all should must invest in this token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1df620e-18d2-4387-a0ca-b0e97f014d49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

