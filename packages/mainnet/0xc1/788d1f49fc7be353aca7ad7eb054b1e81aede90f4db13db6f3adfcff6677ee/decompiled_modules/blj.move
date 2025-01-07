module 0xc1788d1f49fc7be353aca7ad7eb054b1e81aede90f4db13db6f3adfcff6677ee::blj {
    struct BLJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLJ>(arg0, 9, b"BLJ", b"Blazej", b"Meme coin for my cat named Blazej", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f9a9fe3-b95d-44eb-9a7d-9e350378e7db-IMG_7390_VSCO.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

