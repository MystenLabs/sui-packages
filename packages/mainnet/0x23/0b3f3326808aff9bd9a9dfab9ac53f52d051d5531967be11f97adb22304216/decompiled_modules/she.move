module 0x230b3f3326808aff9bd9a9dfab9ac53f52d051d5531967be11f97adb22304216::she {
    struct SHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHE>(arg0, 9, b"SHE", b"SHWANSHEEP", b"AN EXCEPTIONAL MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/120bb249-996b-47da-b181-f4e1142236c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

