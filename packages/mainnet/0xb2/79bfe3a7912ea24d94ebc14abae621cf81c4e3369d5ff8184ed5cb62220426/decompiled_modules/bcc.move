module 0xb279bfe3a7912ea24d94ebc14abae621cf81c4e3369d5ff8184ed5cb62220426::bcc {
    struct BCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCC>(arg0, 6, b"BCC", b"BabyCatCoin", b"Baby Cat is looking for new owner, help the BabyCat by adopting her", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_81c900b825.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

