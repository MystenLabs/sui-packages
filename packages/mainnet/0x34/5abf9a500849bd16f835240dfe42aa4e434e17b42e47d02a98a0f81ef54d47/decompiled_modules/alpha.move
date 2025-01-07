module 0x345abf9a500849bd16f835240dfe42aa4e434e17b42e47d02a98a0f81ef54d47::alpha {
    struct ALPHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHA>(arg0, 9, b"ALPHA", b"ALPHASAM", b"ALPHASAM is a red cryptocurrency designed to promote sustainability and environmental projects. By rewarding eco-friendly initiatives, it empowers users to invest in a cleaner future while supporting innovations that protect our planet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f280f08a-c499-43f1-a1ec-bbfe48eeee52.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALPHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

