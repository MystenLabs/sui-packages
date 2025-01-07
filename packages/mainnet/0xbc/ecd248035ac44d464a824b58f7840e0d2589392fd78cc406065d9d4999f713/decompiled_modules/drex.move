module 0xbcecd248035ac44d464a824b58f7840e0d2589392fd78cc406065d9d4999f713::drex {
    struct DREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREX>(arg0, 9, b"DREX", b"DINO", b"DINO is a cute meme that needs to be carried out by someone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/719b9fd5-d146-4535-a941-5f87048d9b5e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

