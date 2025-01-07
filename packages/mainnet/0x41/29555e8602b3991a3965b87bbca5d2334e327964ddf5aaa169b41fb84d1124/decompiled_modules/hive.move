module 0x4129555e8602b3991a3965b87bbca5d2334e327964ddf5aaa169b41fb84d1124::hive {
    struct HIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIVE>(arg0, 6, b"HIVE", b"Dehive Social", b"The Next-Gen Web3 Social Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050737_3bcc61868e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

