module 0x43f21157330cd357991deb3f63056c726b5a401f3969baf0aaa5760bdc31b4a3::suik {
    struct SUIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIK>(arg0, 6, b"SUIK", b"Sulk", b"Grrrrrrrrrrrrrrrrrrrrrrrrrr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_46_8ccc7e95de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

