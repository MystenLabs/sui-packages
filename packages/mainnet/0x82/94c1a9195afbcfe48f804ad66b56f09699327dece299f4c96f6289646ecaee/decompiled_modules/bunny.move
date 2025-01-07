module 0x8294c1a9195afbcfe48f804ad66b56f09699327dece299f4c96f6289646ecaee::bunny {
    struct BUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNY>(arg0, 9, b"BUNNY", b"Bunny", b"In the realm of Blockchain Burrows, a legendary hero emerges. Ninja Bunny, a stealthy and agile warrior, battles its way through Crypto Caverns, seeking fortune and defending the decentralized kingdom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0057a907-5890-4904-9095-e409275d3a70.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

