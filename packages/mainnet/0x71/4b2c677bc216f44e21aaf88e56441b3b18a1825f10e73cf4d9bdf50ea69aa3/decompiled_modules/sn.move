module 0x714b2c677bc216f44e21aaf88e56441b3b18a1825f10e73cf4d9bdf50ea69aa3::sn {
    struct SN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SN>(arg0, 6, b"SN", b"Real Satoshi", b"SN = SN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/d750644b-fc6c-4598-975b-c1bdca8316b5.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

