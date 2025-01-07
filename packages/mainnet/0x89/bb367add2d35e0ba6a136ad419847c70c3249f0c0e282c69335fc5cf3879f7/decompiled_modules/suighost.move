module 0x89bb367add2d35e0ba6a136ad419847c70c3249f0c0e282c69335fc5cf3879f7::suighost {
    struct SUIGHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGHOST>(arg0, 6, b"SUIGHOST", b"GHOST", b"SUI GHOST always near you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ghost_blue_icon_vector_839644aa5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGHOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGHOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

