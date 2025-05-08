module 0x202c70f4cf051f9b1da02052c54dd902f2296f45d6375a4517bad74b7ef0f61d::bootcamp {
    struct BOOTCAMP has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOOTCAMP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BOOTCAMP>>(0x2::coin::mint<BOOTCAMP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BOOTCAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOTCAMP>(arg0, 6, b"SKG", b"BOOTCAMP", b"BOOTCAMP (SKG) is a commemorative coin created for the first SUI and Move Bootcamp in Thessaloniki, May 2025. It celebrates the spirit of learning, innovation, and community among the inaugular cohort of Move developers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.suicore.com/v1/blobs/8WjkwFrp-Z-ML6hjQUCcTl7pqDD60D1HpbxanopyAgw")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOTCAMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOTCAMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

