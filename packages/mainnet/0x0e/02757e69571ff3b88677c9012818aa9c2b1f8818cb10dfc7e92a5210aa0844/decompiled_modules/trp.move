module 0xe02757e69571ff3b88677c9012818aa9c2b1f8818cb10dfc7e92a5210aa0844::trp {
    struct TRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRP>(arg0, 9, b"TRP", b"TrUmP", b"Trump Coin is a unique cryptocurrency inspired by American values and history. It symbolizes strength, independence, and innovation. By investing in Trump Coin, you support financial freedom and become part of the future of technology and entrepreneurship", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4df174ed-1218-425a-bc70-b7ed7dfe4bec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

