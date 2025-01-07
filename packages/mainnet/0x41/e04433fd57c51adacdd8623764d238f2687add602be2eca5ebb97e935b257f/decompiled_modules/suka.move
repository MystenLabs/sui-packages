module 0x41e04433fd57c51adacdd8623764d238f2687add602be2eca5ebb97e935b257f::suka {
    struct SUKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUKA>(arg0, 9, b"SUKA", b"SuiKa", b"Suika it's meme game ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c30ae31-df79-4aea-9ada-d925047c39ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

