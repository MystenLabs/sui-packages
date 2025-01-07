module 0x7349b87355c681702e3b9a35acff2610ab64c7588e039e2c223adaa2aac7db4e::dmb {
    struct DMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMB>(arg0, 9, b"DMB", b"Dombret", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/789e1670-e392-442b-bd1b-915f9a0d5c23.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

