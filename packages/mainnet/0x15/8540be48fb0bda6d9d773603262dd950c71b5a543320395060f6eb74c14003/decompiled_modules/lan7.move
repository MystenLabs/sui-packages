module 0x158540be48fb0bda6d9d773603262dd950c71b5a543320395060f6eb74c14003::lan7 {
    struct LAN7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAN7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAN7>(arg0, 9, b"LAN7", b"LAN007", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcST5mmtL1tvfkVP410jYizWo3DLefY8NOkdKA&s"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAN7>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAN7>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LAN7>>(v2);
    }

    // decompiled from Move bytecode v6
}

