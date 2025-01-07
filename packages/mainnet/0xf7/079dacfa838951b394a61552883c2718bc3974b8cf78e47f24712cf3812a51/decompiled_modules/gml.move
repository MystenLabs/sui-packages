module 0xf7079dacfa838951b394a61552883c2718bc3974b8cf78e47f24712cf3812a51::gml {
    struct GML has drop {
        dummy_field: bool,
    }

    fun init(arg0: GML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GML>(arg0, 9, b"GML", b"Gombal", b"Big meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5932c955-5293-441a-b5fa-1aa087ac4dab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GML>>(v1);
    }

    // decompiled from Move bytecode v6
}

