module 0xd7c99752c40af60e55f46c96ae1bbbcfe80586bbaf3cfb9fbe18089b06ceda89::hm {
    struct HM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HM>(arg0, 9, b"HM", b"homie", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/OFjRIDm4xg__h4m4ax57pGh7u0BG35tYy80CgmrHbKs")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HM>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HM>>(v1);
    }

    // decompiled from Move bytecode v6
}

