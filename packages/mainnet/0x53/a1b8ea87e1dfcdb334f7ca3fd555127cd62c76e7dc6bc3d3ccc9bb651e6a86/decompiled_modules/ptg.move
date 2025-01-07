module 0x53a1b8ea87e1dfcdb334f7ca3fd555127cd62c76e7dc6bc3d3ccc9bb651e6a86::ptg {
    struct PTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTG>(arg0, 9, b"PTG", b"Puffthedra", b"My first meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5d00b6c-6255-47f2-a814-b4e46fb469c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTG>>(v1);
    }

    // decompiled from Move bytecode v6
}

