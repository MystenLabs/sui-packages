module 0x45641e327eb2ab3e457cd482bbe3902bbcd5851514b2e5fb6c2b38179b49144e::qiqi {
    struct QIQI has drop {
        dummy_field: bool,
    }

    fun init(arg0: QIQI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QIQI>(arg0, 6, b"QiQi", b"Qiqi Cat", b"QiqiCat the cat that meows, now meowing on the Sui Blockchain. QiqiCat is a community-driven memecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_3c3fccd71f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QIQI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QIQI>>(v1);
    }

    // decompiled from Move bytecode v6
}

