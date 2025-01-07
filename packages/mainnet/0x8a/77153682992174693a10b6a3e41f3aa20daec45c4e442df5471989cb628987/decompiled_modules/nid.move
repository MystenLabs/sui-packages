module 0x8a77153682992174693a10b6a3e41f3aa20daec45c4e442df5471989cb628987::nid {
    struct NID has drop {
        dummy_field: bool,
    }

    fun init(arg0: NID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NID>(arg0, 6, b"NID", b"NO IDEA JUST LAUNCHED FOR NO REASON", b"I launched this coin for no reason, buy or not i hardly care", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KS_crunchy_cat_comp_dce62ed558.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NID>>(v1);
    }

    // decompiled from Move bytecode v6
}

