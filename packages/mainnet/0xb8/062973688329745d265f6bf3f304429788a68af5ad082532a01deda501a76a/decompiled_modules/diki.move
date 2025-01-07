module 0xb8062973688329745d265f6bf3f304429788a68af5ad082532a01deda501a76a::diki {
    struct DIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIKI>(arg0, 9, b"DIKI", b"Diki kong", b"Dikikong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/794906e9-51fd-44a3-96a4-410dd378fc74.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

