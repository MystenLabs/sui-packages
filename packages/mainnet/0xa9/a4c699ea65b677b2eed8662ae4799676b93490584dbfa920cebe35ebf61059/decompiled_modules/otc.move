module 0xa9a4c699ea65b677b2eed8662ae4799676b93490584dbfa920cebe35ebf61059::otc {
    struct OTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTC>(arg0, 9, b"OTC", b"Over the Counter", b"https://linktr.ee/OTConSui We're the new way to Swap on Sui. Buy and sell crypto Over The Counter. $OTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blob.suiget.xyz/uploads/img_6847068f39b5b7.67680672.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

