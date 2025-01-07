module 0xeb9531293c7c8998264e7efbee95a0a198d2111c7367ded98552b9823684434c::kata {
    struct KATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KATA>(arg0, 6, b"KATA", b"KATALORIAN", b"WELCOM TO CATS ARMY CATALORIAN !!! IT`S GREAT ARMY FOR SUI !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/333_6830bf3ca4.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

