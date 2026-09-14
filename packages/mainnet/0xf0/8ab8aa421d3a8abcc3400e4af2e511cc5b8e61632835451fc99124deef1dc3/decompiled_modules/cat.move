module 0xf08ab8aa421d3a8abcc3400e4af2e511cc5b8e61632835451fc99124deef1dc3::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"Dog", b"I found cat that looks like a dog old video from 2022", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://koi.family/api/images/321224830edf41502670f463d854473090dfac889b76ee929ba4dbf634e0c43e.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAT>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

