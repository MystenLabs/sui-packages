module 0x220bef6539d63dc67120daed93b99b9176e0a91e688fff544dc2a81504302fa2::twif {
    struct TWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIF>(arg0, 9, b"TWIF", b"Trump Wif ", b"Trump Wif Hat Community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a960a37-825c-47fb-b457-3fb32234ff56.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

