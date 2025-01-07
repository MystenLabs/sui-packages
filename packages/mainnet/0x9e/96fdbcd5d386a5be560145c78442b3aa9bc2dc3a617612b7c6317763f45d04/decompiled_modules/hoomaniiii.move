module 0x9e96fdbcd5d386a5be560145c78442b3aa9bc2dc3a617612b7c6317763f45d04::hoomaniiii {
    struct HOOMANIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOOMANIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOOMANIIII>(arg0, 9, b"HOOMANIIII", b"hoomankhos", b"very nice nft with high utility", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b575d07-a255-4308-a905-59c0b4c7bd28.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOOMANIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOOMANIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

