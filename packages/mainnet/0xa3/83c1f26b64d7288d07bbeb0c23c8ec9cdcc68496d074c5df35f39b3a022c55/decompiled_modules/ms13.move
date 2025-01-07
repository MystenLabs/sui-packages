module 0xa383c1f26b64d7288d07bbeb0c23c8ec9cdcc68496d074c5df35f39b3a022c55::ms13 {
    struct MS13 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MS13, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MS13>(arg0, 6, b"MS13", b"Mara Salvatrucha", b"Join the gang the most dangerous of the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MS_13_bd4acf789f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MS13>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MS13>>(v1);
    }

    // decompiled from Move bytecode v6
}

