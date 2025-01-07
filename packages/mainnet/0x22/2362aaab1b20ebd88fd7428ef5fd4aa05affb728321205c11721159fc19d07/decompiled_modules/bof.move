module 0x222362aaab1b20ebd88fd7428ef5fd4aa05affb728321205c11721159fc19d07::bof {
    struct BOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOF>(arg0, 6, b"BOF", b"BOF MEMECOIN", b"Meet Fiona, a world-famous hippo born six weeks premature at the Cincinnati Zoo and Botanical Garden. Despite weighing only 29 pounds at birth, she overcame numerous challenges to become a beloved symbol of resilience and strength, the reason why she become an internet sensation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_14_22_31_c197e69028.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

