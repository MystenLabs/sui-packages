module 0xf45ef37162e52dc100599feffceb6a6aa6fd140ced701bf993e543c75bb15d3d::mrx {
    struct MRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRX>(arg0, 9, b"MRX", b"MISTERX", b"MRX memes community to unite and free you from the control of a monetary system that regulates, controls and limits. Here, we create educational content and products around the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/284104ed-5334-4a31-b535-d7810163b1c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRX>>(v1);
    }

    // decompiled from Move bytecode v6
}

