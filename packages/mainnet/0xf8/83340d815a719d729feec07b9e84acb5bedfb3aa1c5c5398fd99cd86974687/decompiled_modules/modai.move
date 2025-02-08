module 0xf883340d815a719d729feec07b9e84acb5bedfb3aa1c5c5398fd99cd86974687::modai {
    struct MODAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MODAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MODAI>(arg0, 6, b"MODAI", b"ModAI GPU", b"Run your code at scale with CPU, GPU, and data-heavy workloads. The serverless platform for AI teams.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007367_97f90f3da0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MODAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MODAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

