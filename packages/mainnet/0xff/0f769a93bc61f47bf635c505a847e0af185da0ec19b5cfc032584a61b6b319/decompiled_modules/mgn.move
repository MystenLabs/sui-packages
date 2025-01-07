module 0xff0f769a93bc61f47bf635c505a847e0af185da0ec19b5cfc032584a61b6b319::mgn {
    struct MGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGN>(arg0, 6, b"MGN", b"MEOWGUN", b"The king of the sea - MEOWGUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2567_10_11_at_11_44_23_4c9ddc9756.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGN>>(v1);
    }

    // decompiled from Move bytecode v6
}

