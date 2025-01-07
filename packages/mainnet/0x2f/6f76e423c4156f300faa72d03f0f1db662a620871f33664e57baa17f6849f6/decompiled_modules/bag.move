module 0x2f6f76e423c4156f300faa72d03f0f1db662a620871f33664e57baa17f6849f6::bag {
    struct BAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAG>(arg0, 6, b"Bag", b"Bag of Dicks", b"Send this to an A$$HOLE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_18_at_9_08_32a_PM_47a6ac67ab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

