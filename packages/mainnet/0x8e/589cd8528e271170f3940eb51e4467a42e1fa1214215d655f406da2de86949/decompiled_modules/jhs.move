module 0x8e589cd8528e271170f3940eb51e4467a42e1fa1214215d655f406da2de86949::jhs {
    struct JHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JHS>(arg0, 6, b"JHS", b"Jalen Hurts", b"Jalen Hurts to the rescue, BIRD GANG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jalen_hurts_3c6c822a3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

