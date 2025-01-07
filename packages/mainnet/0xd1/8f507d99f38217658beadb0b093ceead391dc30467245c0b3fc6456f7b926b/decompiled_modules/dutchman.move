module 0xd18f507d99f38217658beadb0b093ceead391dc30467245c0b3fc6456f7b926b::dutchman {
    struct DUTCHMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUTCHMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUTCHMAN>(arg0, 9, b"DUTCHMAN", b"DutchmanS ", b"King of the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aa388c2e-a08a-4e59-a50b-4878a367f0ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUTCHMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUTCHMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

