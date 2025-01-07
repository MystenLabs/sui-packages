module 0xc497af26ef2608d6da484eea0f672f9bb0d07c48cd039cc15db3c91260358c69::suicatsui {
    struct SUICATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATSUI>(arg0, 6, b"SUICATSUI", b"SUICATSUI!", x"54484953204953205355494341545355490a4c4f56452048494d21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/54a884974d10358a18b5333fe7b3b441_7c059aa495.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

