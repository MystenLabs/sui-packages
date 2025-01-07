module 0xd17d04af31fb66c932334aac4d4bbeac16c798187e22cf8e6a5811b7c50d7018::bnb {
    struct BNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNB>(arg0, 9, b"BNB", b"TRINTI", b"TRINTI,Like other cryptocurrencies,it operates on a peer-to-peer network and uses blockchain technology to securely process transactions.This token is created by True Income Tips channel.You can use it safely.Yous all should must invest in this token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/89d1d88f-ef80-4538-b09a-7da3bd4dd997.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

