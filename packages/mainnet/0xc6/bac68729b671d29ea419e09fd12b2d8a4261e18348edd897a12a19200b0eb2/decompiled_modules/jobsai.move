module 0xc6bac68729b671d29ea419e09fd12b2d8a4261e18348edd897a12a19200b0eb2::jobsai {
    struct JOBSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOBSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOBSAI>(arg0, 6, b"JOBSAI", b"JobsAI", b"JobsAI is an innovative job listing platform built for the crypto space, designed to connect talent with opportunities across the blockchain industry. Powered by the SUI Network, JobsAI ensures secure, efficient, and decentralized recruitment processes tailored for Web3 professionals and projects.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Source_07_468cea5bf9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOBSAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOBSAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

