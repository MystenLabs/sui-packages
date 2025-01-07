module 0xa03d08775f3859bedeb9c7de97c06d782b56a2bc41ae3bea7c328e5200fc3074::NavigatorsChain {
    struct NAVIGATORSCHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAVIGATORSCHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAVIGATORSCHAIN>(arg0, 0, b"COS", b"Navigator's Chain", b"Our river shall not yield... The weight of the Chain made to stand amidst the ever-changing current.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Navigator's_Chain.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAVIGATORSCHAIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAVIGATORSCHAIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

