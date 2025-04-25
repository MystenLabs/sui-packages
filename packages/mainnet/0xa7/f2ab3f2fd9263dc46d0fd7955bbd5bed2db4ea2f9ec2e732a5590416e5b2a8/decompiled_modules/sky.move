module 0xa7f2ab3f2fd9263dc46d0fd7955bbd5bed2db4ea2f9ec2e732a5590416e5b2a8::sky {
    struct SKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKY>(arg0, 6, b"SKY", b"Sky", b"Walking towards the stars is a human dream", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mmexport1745558738880_9b16ffbf5a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

