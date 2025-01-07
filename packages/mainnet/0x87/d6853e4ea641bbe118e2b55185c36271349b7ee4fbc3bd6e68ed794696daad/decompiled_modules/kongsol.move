module 0x87d6853e4ea641bbe118e2b55185c36271349b7ee4fbc3bd6e68ed794696daad::kongsol {
    struct KONGSOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONGSOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONGSOL>(arg0, 9, b"KONGSOL", b"Kong", b"Come to Kong Solana meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3207a254-7122-4154-8dd3-f15a3bbc798e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONGSOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KONGSOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

