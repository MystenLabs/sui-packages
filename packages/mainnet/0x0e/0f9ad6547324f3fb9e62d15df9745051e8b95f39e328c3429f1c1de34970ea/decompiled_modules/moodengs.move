module 0xe0f9ad6547324f3fb9e62d15df9745051e8b95f39e328c3429f1c1de34970ea::moodengs {
    struct MOODENGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENGS>(arg0, 6, b"Moodengs", b"Moodeng", b"An unofficial fan page / memecoin of Moo Deng on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_2069fbb18a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

