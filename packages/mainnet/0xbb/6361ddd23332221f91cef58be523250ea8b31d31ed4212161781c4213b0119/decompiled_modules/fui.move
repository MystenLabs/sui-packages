module 0xbb6361ddd23332221f91cef58be523250ea8b31d31ed4212161781c4213b0119::fui {
    struct FUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUI>(arg0, 9, b"Fui", b"no fui bruv", b"N fui no Team get fui then AI can buld fake build team trust me bro LFG trustM 10000 ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/aae0a0dc2e7bccdaf4507e83ce5b4ea2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

