module 0x55c27db5cd92dc069dc4d40d0419a4db7de8c4a60e905d2fb69bd5b0418647e::ray {
    struct RAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAY>(arg0, 6, b"RAY", b"Ray on SUI", b"RAY on SUI. The Ray that smokes under the water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F6_19j0_K_400x400_e1fbb21209.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

