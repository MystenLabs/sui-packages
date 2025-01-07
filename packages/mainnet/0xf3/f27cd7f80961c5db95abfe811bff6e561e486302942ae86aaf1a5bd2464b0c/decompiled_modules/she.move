module 0xf3f27cd7f80961c5db95abfe811bff6e561e486302942ae86aaf1a5bd2464b0c::she {
    struct SHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHE>(arg0, 6, b"SHE", b"SUIperHERO", b"Saving you in times of deep trouble", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5714c74e_45ce_4d3b_8c2a_cd4c92f74320_2c4c2db01c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

