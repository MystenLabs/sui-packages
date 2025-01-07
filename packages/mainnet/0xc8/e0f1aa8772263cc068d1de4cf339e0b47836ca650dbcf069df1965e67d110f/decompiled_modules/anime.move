module 0xc8e0f1aa8772263cc068d1de4cf339e0b47836ca650dbcf069df1965e67d110f::anime {
    struct ANIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANIME>(arg0, 9, b"ANIME", b"MANTAP", b"hahaha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf0822a3-7722-4e51-91fc-29ca6b477e9e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

