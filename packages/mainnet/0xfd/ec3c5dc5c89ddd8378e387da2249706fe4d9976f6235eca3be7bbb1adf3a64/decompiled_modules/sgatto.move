module 0xfdec3c5dc5c89ddd8378e387da2249706fe4d9976f6235eca3be7bbb1adf3a64::sgatto {
    struct SGATTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGATTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGATTO>(arg0, 6, b"SGATTO", b"GATTO", b"Gatto is a cat that often makes a mess and sometimes poses a threat to its environment. At times he is thought to be an alien. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_06_02_19_3b1e827ff3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGATTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGATTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

