module 0xf68e0a48ec8dbaf5c74e2f6f20ad59a0c4ac9863f48c8fcba086814df1131167::suicatsui {
    struct SUICATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATSUI>(arg0, 6, b"SUICATSUI", b"SUICATSUI!", x"535549434154535549210a4c4f56452048494d21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/54a884974d10358a18b5333fe7b3b441_fedee5d2ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

