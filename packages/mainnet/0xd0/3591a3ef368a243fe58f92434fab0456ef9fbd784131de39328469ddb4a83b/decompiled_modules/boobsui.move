module 0xd03591a3ef368a243fe58f92434fab0456ef9fbd784131de39328469ddb4a83b::boobsui {
    struct BOOBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBSUI>(arg0, 6, b"BooBsui", b"Boobsui", b"Hii I'm boobsui a little horny memecoin with squishy, soft, big bouncy eyes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000166598_af371f5ecb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

