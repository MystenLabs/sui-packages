module 0x28e3acd520d04a93b406dd3659f2e3ef5d3f3301cc87d235cc251db90d9ed4a3::bbn {
    struct BBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBN>(arg0, 6, b"BBN", b"Bikini Bottom News", b"Welcome to Bikini Bottom News, where we serve up the latest crypto updates with a side of laughter! Our team of quirky underwater reporters (including SpongeBob and occasionally napping Patrick) dives deep into the ocean of information to deliver the juiciest stories in the SUI World.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_30_22_27_30_6c10a35971.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBN>>(v1);
    }

    // decompiled from Move bytecode v6
}

