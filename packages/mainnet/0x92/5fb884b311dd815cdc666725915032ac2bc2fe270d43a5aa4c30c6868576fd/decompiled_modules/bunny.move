module 0x925fb884b311dd815cdc666725915032ac2bc2fe270d43a5aa4c30c6868576fd::bunny {
    struct BUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNY>(arg0, 9, b"BUNNY", b"Bunny", b"In the realm of Blockchain Burrows, a legendary hero emerges. Ninja Bunny, a stealthy and agile warrior, battles its way through Crypto Caverns, seeking fortune and defending the decentralized kingdom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af95af9d-b920-4b36-aa3d-9f5d9690dd24.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

