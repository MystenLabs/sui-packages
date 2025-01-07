module 0xef38768165670608461360c45ec828dc239158f2476022238ed4dcabf4e91c02::ddt {
    struct DDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDT>(arg0, 9, b"DDT", b"Dedust", x"4974e2809973206a75737420746865206d656d6f727920666f722066756ee28099732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50dbe9a9-f212-4c90-8338-9d30f4da3a32.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

