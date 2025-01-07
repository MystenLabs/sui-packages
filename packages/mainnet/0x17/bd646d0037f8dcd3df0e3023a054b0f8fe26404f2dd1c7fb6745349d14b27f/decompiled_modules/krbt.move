module 0x17bd646d0037f8dcd3df0e3023a054b0f8fe26404f2dd1c7fb6745349d14b27f::krbt {
    struct KRBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRBT>(arg0, 9, b"KRBT", b"KILL ROBOT", b"this meme coin is gonna kill the market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/493af91d-bfae-4bb0-a589-6372b5663c08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

