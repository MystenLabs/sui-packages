module 0x48a58f4db72954639c4a057fc987ca776b0dd92d94bd242c8712cc11a2fc068e::russ {
    struct RUSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSS>(arg0, 6, b"RUSS", b"Narwhal Russ", b"We all need someone like Russ around to remind us we're doin' all right.  Follow me on x.com for updates on how I will spend my money when Russ here makes me into a hundredaire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b6ea5fde_3045_4dda_97c5_bc45c453e622_cf45eb2748.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

