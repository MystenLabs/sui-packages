module 0x5763c757ed24cf2f91cf3307b1ed8fe3b07ec2f91335e73ea4ab9e038e77e57e::sch {
    struct SCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCH>(arg0, 6, b"SCH", b"such", b"most solluable for transection", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a406babaf4d4b0b50f7de90449d820a4_e749872f52.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

