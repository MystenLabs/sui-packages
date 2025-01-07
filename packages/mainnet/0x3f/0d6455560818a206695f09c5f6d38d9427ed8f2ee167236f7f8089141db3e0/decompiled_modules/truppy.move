module 0x3f0d6455560818a206695f09c5f6d38d9427ed8f2ee167236f7f8089141db3e0::truppy {
    struct TRUPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUPPY>(arg0, 6, b"Truppy", b"Trump Puppy", b"Truppy, the 1st Trump Puppy on $SUI Trump Puppy - is the combination of the greatest president to ever grace the United States of America and the cutest dog in the world. Make America Great Again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_07_19_00_32_d04a081445.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

