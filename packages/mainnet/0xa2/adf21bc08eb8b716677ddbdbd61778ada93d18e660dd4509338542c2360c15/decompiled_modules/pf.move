module 0xa2adf21bc08eb8b716677ddbdbd61778ada93d18e660dd4509338542c2360c15::pf {
    struct PF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PF>(arg0, 9, b"PF", b"POCKETFI", b"POCKETFI BOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0dd7bcc-b3a9-4f00-9ac5-6501562cc274.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PF>>(v1);
    }

    // decompiled from Move bytecode v6
}

