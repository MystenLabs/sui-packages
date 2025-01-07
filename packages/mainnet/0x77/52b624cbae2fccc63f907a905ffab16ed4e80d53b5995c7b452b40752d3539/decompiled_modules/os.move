module 0x7752b624cbae2fccc63f907a905ffab16ed4e80d53b5995c7b452b40752d3539::os {
    struct OS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OS>(arg0, 6, b"OS", b"Opensea", b"$OS (OpenSea on Sui): A native token within the Sui Ecosystem, $OS empowers decentralized NFT trading and collectibles on OpenSea's blockchain-driven platform. Designed to optimize scalability, speed, and security, $OS bridges the gap between creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733320515549.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

