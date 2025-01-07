module 0x1288f7803a217e9ad833d7f2f9dd606326a64078332eb04f77e139e7539cd89f::fgd {
    struct FGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGD>(arg0, 6, b"FGD", b"FGG", b"dddd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/506802698_1107183dae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FGD>>(v1);
    }

    // decompiled from Move bytecode v6
}

