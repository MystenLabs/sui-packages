module 0x6d235b2c6783301aa74c1a8ac42cd36181eec28dd0112fee3698619983438df7::fat {
    struct FAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAT>(arg0, 6, b"FAT", b"FATMAN", x"416c7761797320626520796f757273656c662e20556e6c65737320796f752063616e206265204661746d616e2c207468656e206265204661746d616e2e0a4661746d616e206865726520746f207361766520796f7572206173732c206c6574277320676574206675636b696e207269636820746f67657468657220726963686572207468656e20746865207269636869652072696368206d6665727321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ekran_Resmi_2024_10_04_21_47_46_c99cd8d18c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

