module 0xc53c2ec182a6dffe4228a6b53958e46f88733dbb7e29fcb47e5a289d644c232f::dray {
    struct DRAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAY>(arg0, 6, b"DRAY", b"DRAGGY", b"In Matt Furie's graphic novel The Night Riders, there is a dragon character named ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/group_1_copy_mj_E9_O7z_Vg9_H_Za_Wez_c0c9b343bc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

