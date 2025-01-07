module 0x4e682403b295d69b75c9dcb97b82707750f7d05ce3d0c7060c3bd96b769177e1::nme {
    struct NME has drop {
        dummy_field: bool,
    }

    fun init(arg0: NME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NME>(arg0, 9, b"NME", b"Nam Meme ", b"A2 team with love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ccba1bd4-478e-48ef-b681-427344fd6235.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NME>>(v1);
    }

    // decompiled from Move bytecode v6
}

