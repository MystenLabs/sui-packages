module 0xbb7e9d56d39143e8ae2cf3c778bf456004948a04cceeaeb779f3c77bf1c7b6be::bsd {
    struct BSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSD>(arg0, 6, b"BSD", b"BabyScubaDog", b"The cutest scuba diving pooch has landed on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zcb24_PCH_400x400_dd470079a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

