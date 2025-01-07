module 0x3f23b14347918ba7dbad7cbba9b0feefaecc533251ded5b381f924c785367968::ybks {
    struct YBKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YBKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YBKS>(arg0, 9, b"YBKS", b"YOLOBUCKS", x"0a594f4c4f4275636b73206973206120636f6d6d756e6974792d64726976656e206d656d6520746f6b656e2064657369676e656420666f722074686f73652077686f206c697665206c696665206f6e20746865206564676520616e64207365697a65206576657279206f70706f7274756e6974792e20496e7370697265642062792074686520e2809c596f75204f6e6c79204c697665204f6e6365e2809d207068696c6f736f7068792c20594f4c4f4275636b7320656d706f7765727320757365727320746f20656d6272616365207269736b2c20647265616d206269672c20616e642061696d20666f7220746865206d6f6f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/36b222c6-e193-4761-bad2-5114112a8e0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YBKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YBKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

