module 0xda00a3e4fb9c072adce11e65dc083b3e471da15c9dc80c6560a667463b6baf82::fpr {
    struct FPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FPR>(arg0, 9, b"FPR", b"Fly parro", b"The fly parro meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4a78199-20fd-4ee6-a385-17c886b46c8f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FPR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FPR>>(v1);
    }

    // decompiled from Move bytecode v6
}

