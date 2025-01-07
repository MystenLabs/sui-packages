module 0xad11abc03b4ed41e8b6f4a1f57b34b4a57cce134a51bbe9cdb363557dd12a914::ida02 {
    struct IDA02 has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDA02, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDA02>(arg0, 6, b"IDA02", b"Woodland Dreams", b"Original Oil Painting called Woodland Dreams by Ida Fearn. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_12_at_18_22_24_b7b55d1bd4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDA02>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IDA02>>(v1);
    }

    // decompiled from Move bytecode v6
}

