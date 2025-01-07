module 0x7ea84ff64003e97b5988d9e3d95c563c6c14fc3cb1dd3bcfc7c7bcf1b48d8aa7::fls {
    struct FLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLS>(arg0, 9, b"FLS", b"Folks", b"CoinFolks is a Multi-Platform Media that produces creative content, research, and the latest trends about the Web3 Industry. We present curated content to give you another perspective on Blockchain, Crypto Assets, NFTs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eafb3167-64f2-45f2-8726-84aeb534695d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

