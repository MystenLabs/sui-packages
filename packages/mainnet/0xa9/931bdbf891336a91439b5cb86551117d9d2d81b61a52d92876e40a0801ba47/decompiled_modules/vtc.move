module 0xa9931bdbf891336a91439b5cb86551117d9d2d81b61a52d92876e40a0801ba47::vtc {
    struct VTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VTC>(arg0, 9, b"VTC", b"VTCking", b"This is my MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/929b679f-ad70-4be1-8719-203f1e6d3ec3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

