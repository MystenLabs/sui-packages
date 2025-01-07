module 0x4436ff2195a5229fff48e110a67f3a8715517e632a6336cffb59e1f4a457c6d4::holmes {
    struct HOLMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLMES>(arg0, 6, b"HOLMES", b"Homer Holmes", b"A project where the community is a top priority and will decide and endorse the next billion dollar meme. A project like no other. Let your voice be heard.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7e_KK_Vxzg_400x400_abfcecdd8d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

